import Foundation
import UIKit

class SecondViewController: UIViewController {

    var text: String! {
        willSet {
            guard text == nil else { fatalError("Write Once.") }
            guard !isViewLoaded else { fatalError("Must set before view load.") }
        }
    }

    @IBOutlet private weak var textLabel: UILabel!

    override func viewDidLoad() {
        guard text != nil else { fatalError("Must set before view load.") }
        super.viewDidLoad()

        textLabel.text = text
    }
}
