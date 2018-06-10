import UIKit

// Alerts

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
        let description = (error as? LocalizedError)?.errorDescription ?? "Unexpected error occured"

        presentAlert(title: description, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
    }
}

// Top most view controller

extension UIViewController {
    var topMostViewController: UIViewController {
        var viewController = self

        while let presentedViewController = viewController.presentedViewController {
            viewController = presentedViewController
        }

        if let viewController = viewController as? UINavigationController,
            let visibleViewController = viewController.visibleViewController {
            return visibleViewController.topMostViewController
        }

        if let viewController = viewController as? UITabBarController,
            let selectedViewController = viewController.selectedViewController {
            return selectedViewController.topMostViewController
        }

        return viewController
    }
}
