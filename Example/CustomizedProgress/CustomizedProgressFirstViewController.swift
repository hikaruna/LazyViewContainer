import Foundation
import UIKit
import LazyViewContainer

class CustomizedProgressFirstViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ToSecond":
            let lazyViewContainerVC = segue.destination as! LazyViewContainerViewController
            lazyViewContainerVC.doInBackground = { [weak self] in
                sleep(3)
                return self?.storyboard!.instantiateViewController(withIdentifier: "Second")
            }
        default:
            break
        }
    }
}
