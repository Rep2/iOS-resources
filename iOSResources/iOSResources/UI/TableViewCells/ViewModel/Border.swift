enum Border {
    case none
    case border(width: Float, color: UIColor)

    func setBorder(for view: UIView) {
        switch self {
        case .none:
            break
        case .border(let width, let color):
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = CGFloat(width)
        }
    }
}
