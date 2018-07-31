import RxSwift
import FBSDKLoginKit

struct FacebookUser {
    let username: String
    let uid: String
    let accessToken: String
    let firstName: String
    let lastName: String
    let email: String
}

enum FacebookLoginError: Error {
    case tokenNotFound
    case loginFailed
}

class FacebookLoginManager {
    private static let loginManager = FBSDKLoginManager()

    static func connect() -> Observable<FacebookUser> {
        loginManager.logOut()

        return getAutorizationToken()
            .flatMap { token in
                return self
                    .getUserProfile(authorizationToken: token)
        }
    }

    static func disconnect(){
        loginManager.logOut()
    }

    static private func getAutorizationToken() -> Observable<String> {
        return autorizationToken
            .catchError { _ in
                return .create { observer in
                    loginManager
                        .logIn(
                            withReadPermissions: ["public_profile", "email", "user_photos"],
                            from: nil) { results, error -> Void in
                                if let error = error {
                                    observer.onError(error)
                                } else if let results = results,
                                    !results.isCancelled,
                                    let token = results.token?.tokenString {
                                    observer.onNext(token)
                                }

                                observer.onCompleted()
                    }

                    return Disposables.create()
                }
        }
    }

    static private var autorizationToken: Observable<String> {
        guard let facebookToken = FBSDKAccessToken.current()?.tokenString else {
            return .error(FacebookLoginError.tokenNotFound)
        }

        return .just(facebookToken)
    }

    static private func getUserProfile(authorizationToken: String) -> Observable<FacebookUser> {
        guard let profileRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name,email,first_name,last_name,id"]) else {
            return .error(FacebookLoginError.loginFailed)
        }

        return .create { observer in
            profileRequest
                .start() { _, results, error in
                    if let error = error {
                        observer.onError(error)

                        return
                    }

                    if let results = results as? [String: String],
                        let firstName = results["first_name"],
                        let lastName = results["last_name"],
                        let uid = results["id"],
                        let email = results["email"] {

                        let user = FacebookUser(
                            username: firstName + " " + lastName,
                            uid: uid,
                            accessToken: authorizationToken,
                            firstName: firstName,
                            lastName: lastName,
                            email: email
                        )

                        observer.onNext(user)
                        observer.onCompleted()
                    } else {
                        observer.onError(FacebookLoginError.loginFailed)
                    }
            }

            return Disposables.create()
        }
    }
}
