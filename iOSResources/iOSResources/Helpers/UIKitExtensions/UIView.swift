import UIKit

protocol LoadableFromNib {}

extension LoadableFromNib {
    static func loadFromNib() -> Self {
        if let view = UINib(nibName: String(describing: Self.self), bundle: nil).instantiate(withOwner: self, options: nil)[0] as? Self {
            return view
        } else {
            fatalError("Failed to load view from nib")
        }
    }
}
