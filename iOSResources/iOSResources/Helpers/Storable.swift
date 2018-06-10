import Foundation

enum StorableError: Error, LocalizedError {
    case dataNotFound

    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Data not found"
        }
    }
}

protocol Storable: Codable {
    static var identifier: String { get }

    static func fetchFromUserDefaults() throws -> Self
    func saveInUserDefaults() throws
}

extension Storable {
    static var identifier: String {
        return String(describing: Self.self)
    }

    static func fetchFromUserDefaults() throws -> Self {
        guard let decoded = UserDefaults.standard.object(forKey: identifier) as? Data else {
            throw StorableError.dataNotFound
        }

        return try Self.decode(data: decoded)
    }

    func saveInUserDefaults() throws {
        let data = try Self.encode()

        UserDefaults.standard.set(encoded, forKey: identifier)
    }
}

