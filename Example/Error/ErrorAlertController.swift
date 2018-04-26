import Foundation
import UIKit

extension ErrorFirstViewController {

    class ErrorAlertController: UIAlertController {
        convenience init(okAction: @escaping () -> Void) {
            self.init(title: nil, message: "Error", preferredStyle: .alert)
            self.addAction(
                UIAlertAction(title: "OK", style: .default) { _ in
                    okAction()
                }
            )
        }
    }
}
