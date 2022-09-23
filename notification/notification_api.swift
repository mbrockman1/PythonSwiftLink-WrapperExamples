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
            print(title)
            
            self.requestAuthorization { granted in
                if granted {
                    print("Success")
              }
                else {
                    print("Failed")
                }
            }
            // 2
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message

            // 3
            var trigger: UNNotificationTrigger?
            trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: TimeInterval(timing),
                repeats: should_repeat)

            // 4
            if let trigger = trigger {
              let request = UNNotificationRequest(
                identifier: notification_id,
                content: content,
                trigger: trigger)
              // 5
              print("got to step 5")
              UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                  print(error)
                  print("failure")
                }
              }
              print("complete")
            }
            
            
            
    }
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
          // TODO: Fetch notification settings
          completion(granted)
        }
    }

}
