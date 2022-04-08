//
//  NotificationCenter+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Foundation

extension NotificationCenter {
    /// A wrapper for the notifications' names.
    enum NotificationName {
        case notification(Notification)
        case name(Notification.Name)
        case string(String)

        fileprivate var name: Notification.Name {
            switch self {
            case let .notification(notification): return notification.name
            case let .name(name): return name
            case let .string(string): return Notification.Name(string)
            }
        }
    }

    /// A convenience wrapper for the notifications.
    /// - Parameters:
    ///   - forName: the notification's name.
    ///   - sender: the sender criteria of the notification. If `nil`, then it's ignored. By default `nil`.
    ///   - queue: the operation queue where the block runs. If `nil`, the block runs synchronously on the posting thread. By default `.main`.
    ///   - completion: this function gets called after the notification.
    /// - Returns:
    ///     The observer object.
    @discardableResult class func addObserver(forName name: NotificationName,
                                              sender: Any? = nil,
                                              queue: OperationQueue? = .main,
                                              completion: @escaping () -> Void) -> NSObjectProtocol {
        addObserver(forName: name, sender: sender, queue: queue, completion: { _ in completion() })
    }

    /// A convenience wrapper for the notifications.
    /// - Parameters:
    ///   - forName: the notification's name.
    ///   - sender: the sender criteria of the notification. If `nil`, then it's ignored. By default `nil`.
    ///   - queue: the operation queue where the block runs. If `nil`, the block runs synchronously on the posting thread. By default `.main`.
    ///   - completion: this function gets called after the notification.
    /// - Returns:
    ///     The observer object.
    @discardableResult class func addObserver(forName name: NotificationName,
                                              sender: Any? = nil,
                                              queue: OperationQueue? = .main,
                                              completion: @escaping (Notification) -> Void) -> NSObjectProtocol {
        `default`.addObserver(forName: name.name, object: sender, queue: queue, using: completion)
    }

    /// A convenience wrapper for the notifications.
    /// - Parameters:
    ///   - forName: the notification's name.
    ///   - sender: the sender criteria of the notification. If `nil`, then it's ignored. By default `nil`.
    ///   - queue: the operation queue where the block runs. If `nil`, the block runs synchronously on the posting thread. By default `.main`.
    ///   - completion: this function gets called after the notification.
    /// - Returns:
    ///     The observer object.
    @discardableResult class func addObserver(forName name: NSNotification.Name?,
                                              sender: Any? = nil,
                                              queue: OperationQueue? = .main,
                                              completion: @escaping () -> Void) -> NSObjectProtocol {
        addObserver(forName: name, sender: sender, queue: queue, completion: { _ in completion() })
    }

    /// A convenience wrapper for the notifications.
    /// - Parameters:
    ///   - forName: the notification's name.
    ///   - sender: the sender criteria of the notification. If `nil`, then it's ignored. By default `nil`.
    ///   - queue: the operation queue where the block runs. If `nil`, the block runs synchronously on the posting thread. By default `.main`.
    ///   - completion: this function gets called after the notification.
    /// - Returns:
    ///     The observer object.
    @discardableResult class func addObserver(forName name: NSNotification.Name?,
                                              sender: Any? = nil,
                                              queue: OperationQueue? = .main,
                                              completion: @escaping (Notification) -> Void) -> NSObjectProtocol {
        `default`.addObserver(forName: name, object: sender, queue: queue, using: completion)
    }

    /// Post a notification.
    /// - Parameters:
    ///   - notification: the notification's name.
    ///   - sender: the sender of the notification. By default `nil`.
    ///   - userInfo: the content of the notification. By default `nil`.
    class func post(notification: NotificationName, sender: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        `default`.post(name: notification.name, object: sender, userInfo: userInfo)
    }

    /// Remove a notification observer.
    class func remove(observer: NSObjectProtocol?) {
        guard let observer = observer else { return }
        `default`.removeObserver(observer)
    }

    /// Remove the notification observers.
    class func remove(observers: [NSObjectProtocol?]) {
        observers.forEach(remove(observer:))
    }

    /// Remove the notification observers.
    class func remove(observers: NSObjectProtocol?...) {
        remove(observers: observers)
    }
}

extension NotificationCenter {
    /// Return a publisher that emits events when broadcasting notifications.
    /// - Parameters:
    ///   - for: the name of the notification to publish.
    ///   - object: the object posting the named notfication. If `nil`, the publisher emits elements for any object producing a notification with the given name. By default `nil`.
    /// - Returns:
    ///     The publisher that emits events when broadcasting notifications.
    class func publisher(for notification: NotificationName, object: AnyObject? = nil) -> NotificationCenter.Publisher {
        `default`.publisher(for: notification.name, object: object)
    }
}
