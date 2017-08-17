import UIKit

extension UITableView {
    func cell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Unable to dequeue cell of type \(T.self) with identifier \(T.identifier)")
        }
    }
}
