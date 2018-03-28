import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }
}

extension ViewController {
    @objc
    func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }

        viewBottomConstraint.constant = -keyboardSize.height

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }

        viewBottomConstraint.constant = 0

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
