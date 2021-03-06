import Foundation
import UIKit

open class LazyViewContainerViewController: UIViewController {

    open var doInBackground: (() throws -> UIViewController?)! {
        willSet {
            guard !isViewLoaded else { fatalError("Must set before view load.") }
        }
    }

    /// doInBackgroundの処理でerrorがthrowされた場合にmainThreadでcallされる
    /// - parameter error: throwされたerrorObject.
    /// - parameter lazyViewContainerViewController: self.
    open var onError: ((Error, LazyViewContainerViewController) -> Void)?

    open var progressViewController: UIViewController? {
        willSet {
            guard !isViewLoaded else { fatalError("Must set before view load.") }
        }
    }

    private var defaultProgressViewController: UIViewController!

    @IBOutlet private weak var contentContainerView: UIStackView!

    private var contentViewController: UIViewController? {
        willSet {
            guard let contentViewController = self.contentViewController else { return }
            contentViewController.willMove(toParentViewController: nil)
            contentContainerView.subviews.forEach { $0.removeFromSuperview() }
            contentViewController.removeFromParentViewController()
        }
        didSet {
            guard let contentViewController = self.contentViewController else { return }
            addChildViewController(contentViewController)
            contentContainerView.addArrangedSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
        }
    }

    open override func viewDidLoad() {
        guard doInBackground != nil else { fatalError("Must set before view load.") }

        super.viewDidLoad()

        contentViewController = progressViewController ?? defaultProgressViewController

        DispatchQueue.global(qos: .default).async { [weak self] in
            do {
                guard let contentViewController = try self?.doInBackground() else { return }

                DispatchQueue.main.async { [weak self] in
                    self?.contentViewController = contentViewController
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    self.onError?(error, self)
                }
            }
        }
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "EmbedDefaultProgress":
            defaultProgressViewController = segue.destination
        default:
            break
        }
    }
}
