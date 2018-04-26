import Foundation
import UIKit
import LazyViewContainer

class UnwindSignupFormViewController: UIViewController {

    var name: String {
        return nameField?.text ?? ""
    }

    @IBOutlet private weak var nameField: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "OnSubmit":
            let lazyViewContainerVC = segue.destination as! LazyViewContainerViewController
            lazyViewContainerVC.doInBackground = { [weak self] in
                sleep(3)

                guard let `self` = self else { return nil }
                DispatchQueue.main.sync { [weak self] in
                    guard let `self` = self else { return }
                    self.performSegue(withIdentifier: "PostSubmit", sender: self)
                }
                return nil
            }
        default:
            break
        }
    }
}
