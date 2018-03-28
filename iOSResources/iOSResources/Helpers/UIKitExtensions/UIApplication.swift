import UIKit
import Crashlytics

extension UIApplication {
    func loggedOpenUrl(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        } else {
            Crashlytics
                .sharedInstance()
                .recordErrorOnBackgroundThread(GenericError.cannotOpen(urlString: urlString))
        }
    }
}
