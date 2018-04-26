import Foundation
import UIKit

class UnwindBaseViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!

    @IBAction func unwindToBase(segue: UIStoryboardSegue) {
        switch segue.identifier ?? "" {
        case "PostSubmit":
            let formVC = segue.source as! UnwindSignupFormViewController
            nameLabel.text = "Your name is \(formVC.name)"
        default:
            break
        }
    }
}
