import CoreLocation

protocol LocationManagerDelegate {
    func locationService(_ service: LocationManager, _ currentLocation: CLLocation, _ seconds: TimeInterval)
    func locationService(_ service: LocationManager, _ error: Error)
    func locationService(_ service: LocationManager, _ timer: Timer)
}

class LocationManager: NSObject {
    static let shared: LocationManager = LocationManager()

//    private var timer: Timer?
//    private var seconds:TimeInterval = 0
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        guard let locationManager = self.locationManager else { return }
        self.locationManager(locationManager, status: CLLocationManager.authorizationStatus())
    }
    
    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager?.startUpdatingLocation()
//            startTimer()
        }
    }
    
   func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
//        stopTimer()
    }
    
    private func locationManager(_ manager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .restricted, .denied:
            disableLocationBasedFeatures()
        case .authorizedWhenInUse:
            disableLocationBasedFeatures()
        case .authorizedAlways:
            enableLocationBasedFeatures(manager)
        }
    }
    
    private  func enableLocationBasedFeatures(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            startUpdatingLocation()
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager.distanceFilter =  1
        }
    }
    
    private func disableLocationBasedFeatures() {
//        UIAlertController.showAlert(title: "설정",
//                                    message: "1.설정>개인 정보 보호>위치서비스>위치 서비스 사용\n2.설정>개인 정보 보호>위치 서비스>\(ApplicationInfo.appName)>위치>항상",
//            actions: [UIAlertAction(title: "확인", style: .default, handler: { (UIAlertAction) in
//                guard let url = URL(string: UIApplicationOpenSettingsURLString) else {return}
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url)
//                } else {
//                    UIApplication.shared.openURL(url)
//
//                }
//            })])
    }
    
//    func startTimer() {
//        if self.timer == nil {
//            if #available(iOS 10.0, *) {
//                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//                    self.updateTime()
//                }
//            } else {
//                self.timer = Timer.scheduledTimer(timeInterval: 1,
//                                                  target: self,
//                                                  selector: #selector(updateTime),
//                                                  userInfo: nil,
//                                                  repeats: true)
//            }
//        }
//    }
//
//    func stopTimer() {
//        self.timer?.invalidate()
//        self.timer = nil
//        self.seconds = 0
//    }
    
//    @objc private func updateTime() {
//        self.seconds += 1;
//        guard let timer = self.timer else {return}
//        self.delegate?.locationService(self, timer)
//    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.currentLocation = location        // singleton for get last(current) location
        guard let currentLocation = self.currentLocation else {return}
        self.delegate?.locationService(self, currentLocation, self.seconds)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.locationService(self, error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager(manager, status: status)
    }
}
