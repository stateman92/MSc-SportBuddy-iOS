//
//  NotificationServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 26..
//

import UserNotifications

/// A class for managing the notifications.
final class NotificationServiceImpl: Initable {
    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - NotificationService

extension NotificationServiceImpl: NotificationService {
    /// Send a notification
    /// - Parameters:
    ///   - title: the title of the notification.
    ///   - subtitle: the subtitle of the notification. By default `nil`.
    ///   - sound: the sound of the notification. By default `.default`.
    ///   - timing: the timing of the notification. By default `.now`.
    func sendNotification(title: String,
                          subtitle: String? = nil,
                          sound: UNNotificationSound? = .default,
                          timing: NotificationTiming = .now) {
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle {
            content.subtitle = subtitle
        }
        content.sound = sound
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timing.timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
