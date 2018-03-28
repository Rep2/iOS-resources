class PopoverViewController: UIViewController {
    let popoverView: UIView

    init(popoverView: UIView) {
        self.popoverView = popoverView

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopoverViewController.didTapBackground)))

        view.addSubview(popoverView)

        popoverView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        popoverView.layer.cornerRadius = 5
        popoverView.layer.masksToBounds = true
    }

    @objc
    func didTapBackground() {
        dismiss(animated: true, completion: nil)
    }

    func addEdgeConstraints(edgeInsets: UIEdgeInsets) {
        popoverView.snp.makeConstraints { make in
            make.edges.equalTo(self.view).inset(edgeInsets)
        }
    }

    static func presentPopupViewController(withBaseView view: UIView) -> PopoverViewController {
        let popoverViewController = PopoverViewController(popoverView: view)
        popoverViewController.modalPresentationStyle = .overFullScreen
        popoverViewController.modalTransitionStyle = .crossDissolve

        topMostViewController.present(popoverViewController, animated: true, completion: nil)

        return popoverViewController
    }
}
