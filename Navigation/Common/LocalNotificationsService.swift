//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 13.09.2022.
//

import Foundation
import UserNotifications
import UIKit

final class LocalNotificationsService {
    private let center = UNUserNotificationCenter.current()
    private let everyDayNotificationIndetifier = "everyDayNotificationIndetifier"
    
    private func requestAuthorization(competion: @escaping () -> Void) {
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { result, error in
            if result {
                competion()
            }
        }
    }
    
    func registeForLatestUpdatesIfPossible() {
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Откройте приложение"
        content.badge = 1
        var dataComponent = DateComponents()
        dataComponent.hour = 19
        dataComponent.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponent, repeats: true)
        
        requestAuthorization {
            let request = UNNotificationRequest(identifier: self.everyDayNotificationIndetifier, content: content, trigger: trigger)
            self.center.add(request, withCompletionHandler: nil)
        }
    }
}
