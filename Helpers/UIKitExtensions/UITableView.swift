import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) where T: Identifiable {
        register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
}
