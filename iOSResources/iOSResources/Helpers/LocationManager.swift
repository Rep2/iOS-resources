import CoreLocation
import RxSwift

enum LocationManagerError: Error {
    case locationServiceNotEnabled
    case notInitialized
}

class LocationManager: NSObject {
    static let sharedInstance = LocationManager()

    fileprivate lazy var clLocationManager: CLLocationManager = {
        let locationManager = CLLocationManager()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10

        return locationManager
    }()

    fileprivate lazy var locationSubject = BehaviorSubject<Result<CLLocation>>(value: .error(LocationManagerError.notInitialized))

    var locationObservable: Observable<Result<CLLocation>> {
        return locationSubject.asObservable()
    }

    private override init() {
        super.init()

        authorizationStatusDidChange(CLLocationManager.authorizationStatus())
    }

    func startUpdatingLocation() {
        clLocationManager.startUpdatingLocation()
    }

    func authorizationStatusDidChange(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            clLocationManager.startUpdatingLocation()
        case .notDetermined:
            clLocationManager.requestAlwaysAuthorization()
        default:
            locationSubject.onNext(.error(LocationManagerError.locationServiceNotEnabled))
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusDidChange(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationSubject.onNext(.value(lastLocation))
        }
    }
}

