import UIKit

enum Storyboards: String {
    case main = "Main"

    /*
     Instantiates viewController from storyboard using its identifier.

     Warning - silent fail, test all usage
     */
    func viewController<T: UIViewController>() -> T {
        if let viewController = UIStoryboard(name: self.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: self)) as? T {
            return viewController
        } else {
            fatalError("Failed to initialize view controller registerd in storyboard \(String(describing: self)) using identifier \(String(describing: T.self))")
        }
    }
}

