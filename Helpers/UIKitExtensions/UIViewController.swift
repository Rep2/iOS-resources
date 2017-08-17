import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String? = nil, preferredStyle: UIAlertControllerStyle = .actionSheet, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        actions
            .forEach {
                alertController.addAction($0)
            }

        present(alertController, animated: true, completion: nil)
    }
}
