import Crashlytics

enum UserDefaultsError: Error {
    case dataNotFound
}

extension Decodable {
    static func fromUserDefaults() throws -> Self {
        guard let data = UserDefaults.standard.object(forKey: String(describing: type(of: self))) as? Data else {
            throw UserDefaultsError.dataNotFound
        }

        return try PropertyListDecoder().decode(Self.self, from: data)
    }
}

extension Encodable {
    func saveInUserDefaults() throws {
        let encoded = try PropertyListEncoder().encode(self)

        UserDefaults.standard.set(encoded, forKey: String(describing: type(of: self)))
    }

    func loggedSaveInUserDefaults() {
        do {
            try saveInUserDefaults()
        } catch let error {
            Crashlytics
                .sharedInstance()
                .recordErrorOnBackgroundThread(
                    error,
                    withAdditionalUserInfo: [
                        "location": "saveInUserDefaults",
                        "type": String(describing: type(of: self))
                    ]
            )
        }
    }
}
