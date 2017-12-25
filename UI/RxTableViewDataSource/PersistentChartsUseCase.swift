import RxSwift

class PersistentChartsUseCase {
    /// Render artefacts persistently stored on device
    private(set) static var persistentCharts: [Chart] = {
        guard let charts = try? [Chart].fromUserDefaults() else { return [] }

        return charts
        }() {
        didSet {
            persistentCharts.loggedSaveInUserDefaults()

            chartsSubject.onNext(persistentCharts)
        }
    }

    static let chartsObservable: Observable<[Chart]> = {
        return chartsSubject.asObservable()
    }()

    static func appendOrReplace(charts: Chart) {
        if let index = persistentCharts.enumerated().first(where: { $0.element == charts })?.offset {
            persistentCharts[index] = charts
        } else {
            persistentCharts.append(charts)
        }
    }

    static func deleteChart(at index: Int) {
        _ = persistentCharts.remove(safeAt: index)
    }

    private static let chartsSubject: BehaviorSubject<[Chart]> = {
        return BehaviorSubject(value: persistentCharts)
    }()
}
