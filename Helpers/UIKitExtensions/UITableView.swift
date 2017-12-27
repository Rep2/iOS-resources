import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        register(UINib(nibName: String(describing: cellType.self), bundle: nil), forCellReuseIdentifier: String(describing: cellType.self))
    }
    
    func cell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        } else {
            fatalError("Unable to dequeue cell with identifier \(String(describing: T.self))")
        }
    }
}

