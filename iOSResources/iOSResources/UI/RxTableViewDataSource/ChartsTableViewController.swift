import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol ChartsPresenterOutput {
    var localArtefacts: Driver<[Section<ChartsViewModel>]> { get }

    func deleteChart(at indexPath: IndexPath)
    func openChart(at indexPath: IndexPath)
}

class ChartsTableViewController: UITableViewController {
    var presenterOutput: ChartsPresenterOutput!

    lazy var dataSource: RxTableViewSectionedReloadDataSource<Section<ChartsViewModel>> = {
        return RxTableViewSectionedReloadDataSource<Section<ChartsViewModel>>(
            configureCell: { _, tableView, indexPath, viewModel -> UITableViewCell in
                let cell = tableView.cell(for: indexPath) as ChartCell

                cell.present(viewModel: viewModel)

                return cell
        }, canEditRowAtIndexPath: { _, _ -> Bool in
            return true
        })
    }()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(cellType: ChartCell.self)

        presenterOutput
            .localArtefacts
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        title = "Charts"
    }
}

extension ChartsTableViewController {
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
                self.presentAlert(
                    title: "Are you sure you want to delete the selected chart",
                    message: "This action cannot be undone",
                    preferredStyle: .alert,
                    actions: [
                        UIAlertAction(title: "OK", style: .default) { _ in
                            self.presenterOutput.deleteChart(at: indexPath)
                        },
                        UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                    ]
                )
            },
            UITableViewRowAction(style: .normal, title: "Open") { _, indexPath in
                self.presentAlert(
                    title: "Are you sure you want to open the selected chart",
                    message: "Unsaved changes will be discarded",
                    preferredStyle: .alert,
                    actions: [
                        UIAlertAction(title: "OK", style: .default) { _ in
                            self.presenterOutput.openChart(at: indexPath)
                        },
                        UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                    ]
                )
            }
        ]
    }
}
