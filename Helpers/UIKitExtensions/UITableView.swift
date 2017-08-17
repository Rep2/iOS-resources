import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType: T.Type) where T: Identifiable {
        register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }

    func cell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Unable to dequeue cell of type \(T.self) with identifier \(T.identifier)")
        }
    }
}
