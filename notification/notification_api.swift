import Foundation
import NotificationCenter

class NotificationApi {
    init() {
        InitNotificationApi_Delegate(delegate: self)
    }
}

extension NotificationApi: NotificationApi_Delegate {

    func do_notify(
        title: String,
        message: String,
        timing: Int,
        notification_id: String,
        should_repeat: Bool) {
            self.requestAuthorization { granted in
                if granted {
                    print("Success")
              }
                else {
                    print("Failed")
                }
            }
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message

            var trigger: UNNotificationTrigger?
            trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: TimeInterval(timing),
                repeats: should_repeat)

            if let trigger = trigger {
              let request = UNNotificationRequest(
                identifier: notification_id,
                content: content,
                trigger: trigger)
              // 5
              UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                  print(error)
                }
              }
            }
    }
    
    func remove_notifications_func(notification_id: String){
        UNUserNotificationCenter.current()
          .removePendingNotificationRequests(withIdentifiers: [notification_id])
      }
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
          // TODO: Fetch notification settings
          completion(granted)
        }
    }

}
