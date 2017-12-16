import Foundation

protocol Storable: class {
    static var identifier: String { get }
    static var className: String { get }

    static func fetchFromUserDefaults() -> Self?
    static func removeFromUserDefaults()
    func saveInUserDefaults()
}

extension Storable {
    static var identifier: String {
        return String(describing: Self.self)
    }

    static var className: String {
        return String(describing: Self.self)
    }

    static func fetchFromUserDefaults() -> Self? {
        guard let data = UserDefaults.standard.object(forKey: identifier) as? Data else {
            return nil
        }

        NSKeyedUnarchiver.setClass(Self.self, forClassName: className)

        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
    }

    static func removeFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: identifier)
    }

    func saveInUserDefaults() {
        NSKeyedArchiver.setClassName(Self.className, for: Self.self)

        let data = NSKeyedArchiver.archivedData(withRootObject: self)

        UserDefaults.standard.set(data, forKey: Self.identifier)
    }
}
