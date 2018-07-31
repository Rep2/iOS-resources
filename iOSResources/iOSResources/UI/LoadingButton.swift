import UIKit

class LoadingButton: UIButton {
    var title: String?

    lazy var smallActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)

        activityIndicator.hidesWhenStopped = true

        self.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.center.equalTo(self)
        }

        return activityIndicator
    }()

    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)

        self.title = title
    }

    func startLoading() {
        UIView
            .transition(
                with: self,
                duration: 0.3,
                options: .transitionFlipFromTop,
                animations: {
                    self.setTitle(nil, for: .normal)
                    self.smallActivityIndicator.startAnimating()
            }
        )
    }

    func stopLoading() {
        setTitle(title, for: .normal)
        smallActivityIndicator.stopAnimating()
    }
}
