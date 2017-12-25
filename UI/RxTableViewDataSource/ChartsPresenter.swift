import RxSwift
import RxCocoa

protocol ChartsDelegate: class {
    func open(chart: Chart)
}

class ChartsPresenter {
    unowned let delegate: ChartsDelegate

    init(delegate: ChartsDelegate) {
        self.delegate = delegate
    }
}

extension ChartsPresenter: ChartsPresenterOutput {
    func deleteChart(at indexPath: IndexPath) {
        PersistentChartsUseCase.deleteChart(at: indexPath.row)
    }

    func openChart(at indexPath: IndexPath) {
        guard let chart = PersistentChartsUseCase.persistentCharts.get(safeAt: indexPath.row) else { return }

        delegate.open(chart: chart)
    }

    var localArtefacts: Driver<[Section<ChartsViewModel>]> {
        return PersistentChartsUseCase
            .chartsObservable
            .map {
                [
                    Section(items: $0.map { ChartsViewModel(chart: $0) })
                ]
            }
            .asDriver(onErrorJustReturn: [])
    }
}
