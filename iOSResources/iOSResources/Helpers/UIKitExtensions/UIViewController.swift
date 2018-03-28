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

    func presentAlert(error: Error) {
        let description = (error as? LocalizedError).errorDescription ?? "Unexpected error occured"

        presentAlert(title: description, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
    }
}

// MARK VC presenting

extension UIViewController {
    static func presentAsPopup(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve

        present(viewController, animated: animated, completion: nil)
    }
}
