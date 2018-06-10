import Crashlytics

class Logger {
    func log(error: Error, withAdditionalUserInfo additionalUserInfo: [String: Any]) {
        recordErrorOnBackgroundThread(error, withAdditionalUserInfo: additionalUserInfo)
    }

    func recordErrorOnBackgroundThread(_ error: Error) {
        DispatchQueue.global(qos: .background).async {
            Crashlytics.sharedInstance().recordError(error)
        }
    }

    func recordErrorOnBackgroundThread(_ error: Error, withAdditionalUserInfo additionalUserInfo: [String : Any]?) {
        DispatchQueue.global(qos: .background).async {
            Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: additionalUserInfo)
        }
    }
}
