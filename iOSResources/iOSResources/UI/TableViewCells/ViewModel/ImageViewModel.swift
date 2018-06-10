import UIKit

struct ImageViewModel {
    let viewViewModel: ViewViewModel
    let image: UIImage?

    init(image: UIImage?, viewViewModel: ViewViewModel) {
        self.image = image
        self.viewViewModel = viewViewModel
    }
}
