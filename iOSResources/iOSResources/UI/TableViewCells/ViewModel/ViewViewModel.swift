struct ViewViewModel {
    let backgroundColor: UIColor
    let border: Border
    let cornerRadius: CGFloat

    init(backgroundColor: UIColor = .white, border: Border = .none, cornerRadius: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.border = border
        self.cornerRadius = cornerRadius
    }
}
