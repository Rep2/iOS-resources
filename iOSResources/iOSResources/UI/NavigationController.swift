import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = ColorManager.primaryColor
        navigationBar.tintColor = ColorManager.primaryTextColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: ColorManager.primaryTextColor]
        navigationBar.isTranslucent = false
    }
}
