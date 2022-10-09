//
//  NotificationService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 26..
//

import UserNotifications

/// A protocol for managing the notifications.
protocol NotificationService: Initable, AutoMockable {
    /// Send a notification
    /// - Parameters:
    ///   - title: the title of the notification.
    ///   - subtitle: the subtitle of the notification.
    ///   - sound: the sound of the notification.
    ///   - timing: the timing of the notification.
    func sendNotification(title: String, subtitle: String?, sound: UNNotificationSound?, timing: NotificationTiming)
}

extension NotificationService {
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
        sendNotification(title: title, subtitle: subtitle, sound: sound, timing: timing)
    }
}
