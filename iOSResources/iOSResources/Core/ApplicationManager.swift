import UIKit

class ApplicationManager {
    static let shared = ApplicationManager()

    lazy var rootViewController: UIViewController = {
        return NavigationController(rootViewController: ResearchCodesViewController(nibName: nil, bundle: nil))
    }()

    var topMostViewController: UIViewController {
        return rootViewController.topMostViewController
    }
}
