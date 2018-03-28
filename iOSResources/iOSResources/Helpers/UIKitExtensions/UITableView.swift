import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        register(UINib(nibName: String(describing: cellType), bundle: nil), forCellReuseIdentifier: String(describing: cellType))
    }

    func registerClass<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type.self))
    }

    func cell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        } else {
            fatalError("Unable to dequeue cell with identifier \(String(describing: T.self))")
        }
    }
}
