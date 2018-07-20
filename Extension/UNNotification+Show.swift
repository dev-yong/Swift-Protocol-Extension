//
//  UNNotification.swift
//  BBS
//
//  Created by 이광용 on 2018. 7. 20..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation
import UserNotifications

extension UNNotification {
    static func showNotification(title: String, subtitle: String, body: String, categoryIdentifier: String, requestIdentifier: String) {
        let content = createNotificationContent(title: title,
                                                subtitle: subtitle,
                                                body: body,
                                                categoryIdentifier: categoryIdentifier)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                debugPrint("Error posting notification:\(error.localizedDescription)")
            }
        }
    }
    
    static func createNotificationContent(title: String, subtitle: String, body: String, categoryIdentifier: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.categoryIdentifier = categoryIdentifier
//        content.sound = UNNotificationSound.default()
        return content
    }
}

/*
UNNotification.showNotification(title: "title",
                                subtitle: "subtitle",
                                body: "body",
                                categoryIdentifier: "category",
                                requestIdentifier: "request")
*/
