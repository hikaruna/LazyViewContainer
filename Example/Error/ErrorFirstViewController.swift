import Foundation
import UIKit
import LazyViewContainer

class ErrorFirstViewController: UIViewController {

    private var isErrorEnabled = true

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ToSecond":
            let lazyViewContainerVC = segue.destination as! LazyViewContainerViewController
            lazyViewContainerVC.doInBackground = { [weak self] in
                sleep(3)
                guard let `self` = self else { return nil }

                if self.isErrorEnabled {
                    throw SampleError.sample
                }

                return self.storyboard!.instantiateViewController(
                    withIdentifier: "Second"
                )
            }

            lazyViewContainerVC.onError = { [weak self] (error, lazyViewContainerVC) in
                self?.onToSecondError(error: error, lazyViewContainerVC: lazyViewContainerVC)
            }
        default:
            break
        }
    }

    private func onToSecondError(error: Error, lazyViewContainerVC: LazyViewContainerViewController) {
        lazyViewContainerVC.present(
            ErrorAlertController(okAction: { [weak lazyViewContainerVC] in
                lazyViewContainerVC?.navigationController?.popViewController(animated: true)
            }),
            animated: true
        )
    }

    @IBAction private func isErrorSwitchValueChanged(_ sender: UISwitch) {
        isErrorEnabled = sender.isOn
    }
}
