import UIKit

class TableViewControllerWithRefreshControl: UITableViewController {
    private lazy var notFoundLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))

        label.text = NSLocalizedString("No data", comment: "No data table view label text")
        label.textColor = .darkGray
        label.isHidden = true
        label.textAlignment = .center

        self.tableView.backgroundView = label

        return label
    }()

    private var isAnimating: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.isAnimating {
            self.startAnimatingRefreshControl()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        refreshControl?.endRefreshing()
        tableView.setContentOffset(.zero, animated: true)
    }

    public func setNotFoundLabelText(_ text: String) {
        notFoundLabel.text = text
    }

    public func didStartLoading() {
        isAnimating = true

        startAnimatingRefreshControl()
    }

    public func didEndLoading(isEmpty: Bool) {
        isAnimating = false

        stopAnimatingRefreshControl(isEmpty: isEmpty)
    }

    private func startAnimatingRefreshControl() {
        tableView.setContentOffset(CGPoint(x: 0, y: -(refreshControl?.bounds.height ?? 0)), animated: false)
        refreshControl?.beginRefreshing()
    }

    private func stopAnimatingRefreshControl(isEmpty: Bool) {
        refreshControl?.endRefreshing()
        notFoundLabel.isHidden = !isEmpty
    }

    func reloadData(isRefreshing: Bool) {
        notFoundLabel.isHidden = numberOfSections(in: tableView) > 0
    }
}
