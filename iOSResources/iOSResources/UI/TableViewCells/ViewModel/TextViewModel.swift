struct TextViewModel {
    var text: String?
    let textColor: UIColor
    let font: UIFont

    init(text: String?, textColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 15)) {
        self.text = text
        self.textColor = textColor
        self.font = font
    }
}
