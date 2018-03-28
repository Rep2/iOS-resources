protocol Singleton {
    static var shared: Self { get }

    init()
}

extension Singleton {
    static var shared: Self {
        return Self()
    }
}
