import UserNotifications

class RepeatNotificaionManager: NSObject {
    static let shared = RepeatNotificaionManager()
    private var timer: Timer?
    private var timeInterver: TimeInterval = 3.0
    override private init() {
        super.init()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (permission, error) in
            if let error = error {
                NSLog(error.localizedDescription)
            }
        }
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopPush),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
    }
    
    func startPush(){
        if self.timer == nil {
            if #available(iOS 10.0, *) {
                self.timer = Timer.scheduledTimer(withTimeInterval: self.timeInterver, repeats: true) { (timer) in
                    self.showNotification()
                }
            } else {
                self.timer = Timer.scheduledTimer(timeInterval: self.timeInterver,
                                                  target: self,
                                                  selector: #selector(showNotification),
                                                  userInfo: nil,
                                                  repeats: true)
            }
        }
    }
    
    @objc func stopPush(){
        self.timer?.invalidate()
        self.timer = nil
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    @objc private func showNotification() {
        UNNotification.showNotification(title: "title",
                                        subtitle: "subtitle",
                                        body: "body",
                                        categoryIdentifier: "category",
                                        requestIdentifier: "request")
    }
}

extension RepeatNotificaionManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}
