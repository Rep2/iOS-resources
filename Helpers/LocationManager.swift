import CoreLocation
import RxSwift

enum LocationManagerError: Error, LocalizedError {
    case locationServicesNotAuthorizedByUser
    case locationServicesNotEnabled

    var errorDescription: String? {
        switch self {
        case .locationServicesNotEnabled:
            return "The location service is not enabled. Your device might not be able to collect location data."
        case .locationServicesNotAuthorizedByUser:
            return "The location service is not authorized. If you would like to use the app, enable the location service in the settings."
        }
    }
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

    fileprivate lazy var authorizationStatusSubject = BehaviorSubject<CLAuthorizationStatus>(value: CLLocationManager.authorizationStatus())
    fileprivate lazy var locationSubject = BehaviorSubject<CLLocation?>(value: nil)

    var authorizationStatusObservable: Observable<CLAuthorizationStatus> {
        return authorizationStatusSubject.asObservable()
    }

    var locationObservable: Observable<CLLocation?> {
        isLocationServiceEnabled() { isEnabled in
            if isEnabled {
                clLocationManager.startUpdatingLocation()
            }
        }

        return locationSubject.asObservable()
    }

    func isLocationServiceEnabled(callback: (Bool) -> Void) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            callback(true)
        case .notDetermined:
            clLocationManager.requestAlwaysAuthorization()
        default:
            callback(false)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            clLocationManager.startUpdatingLocation()
        }

        authorizationStatusSubject.onNext(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationSubject.onNext(locations.last)
    }
}
