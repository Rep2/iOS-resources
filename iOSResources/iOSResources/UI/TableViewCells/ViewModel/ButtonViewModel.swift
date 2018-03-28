class ButtonViewModel {
    let titleViewModel: TextViewModel
    let viewViewModel: ViewViewModel

    let didTapButtonCallback: () -> Void

    init(titleViewModel: TextViewModel, buttonViewModel: ViewViewModel, didTapButtonCallback: @escaping () -> Void) {
        self.titleViewModel = titleViewModel
        self.viewViewModel = buttonViewModel
        self.didTapButtonCallback = didTapButtonCallback
    }
}
