import UIKit

class ViewControllerWithRefreshControl: ViewController {
    @IBOutlet weak var tableView: UITableView!

    lazy var notFoundLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        label.text = LocalizedFormatString("connection_view.not_found.message")
        label.font = UIFont(name: "Lato-Regular", size: 16)
        label.textColor = .darkGray
        label.isHidden = true
        label.textAlignment = .center

        self.tableView.backgroundView = label

        return label
    }()

    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.addSubview(refreshControl)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.startAnimatingRefreshControl()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        refreshControl.endRefreshing()
        tableView.setContentOffset(.zero, animated: true)
    }

    func setNotFoundLabelText(_ text: String) {
        notFoundLabel.text = text
    }

    func startAnimatingRefreshControl() {
        tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.bounds.height), animated: false)
        refreshControl.beginRefreshing()
    }

    func endRefreshing(itemCount: Int) {
        refreshControl.endRefreshing()
        tableView.reloadData()
        notFoundLabel.isHidden = itemCount > 0
    }
}
