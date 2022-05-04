//
//  KeyboardObserver.swift
//  UILibrary
//
//  Created by Kálai Kristóf on 2021. 09. 30..
//  Copyright © 2021. Kálai Kristóf. All rights reserved.
//

import Combine
import UIKit

/// A singleton class to deal with keyboard updates.
final class KeyboardObserver {
    /// Singleton.
    static let shared = KeyboardObserver()

    private(set) var willShowNotification = PassthroughSubject<Notification, Never>()
    private(set) var willHideNotification = PassthroughSubject<Notification, Never>()
    private(set) var didShowNotification = PassthroughSubject<Notification, Never>()
    private(set) var didHideNotification = PassthroughSubject<Notification, Never>()
    private(set) var keyboardWillChangeFrameNotification = PassthroughSubject<Notification, Never>()
    private(set) var keyboardDidChangeFrameNotification = PassthroughSubject<Notification, Never>()
    private var cancellables = Set<AnyCancellable>()

    /// The programmer's given subscribers.
    private var functions = [UUID: (notification: Notification) -> Void]()

    private init() {
        NotificationCenter.publisher(for: .name(UIResponder.keyboardWillShowNotification))
            .forward(to: willShowNotification, in: &cancellables)
        NotificationCenter.publisher(for: .name(UIResponder.keyboardWillHideNotification))
            .forward(to: willHideNotification, in: &cancellables)
        NotificationCenter.publisher(for: .name(UIResponder.keyboardDidShowNotification))
            .forward(to: didShowNotification, in: &cancellables)
        NotificationCenter.publisher(for: .name(UIResponder.keyboardDidHideNotification))
            .forward(to: didHideNotification, in: &cancellables)
        NotificationCenter.publisher(for: .name(UIResponder.keyboardWillChangeFrameNotification))
            .forward(to: keyboardWillChangeFrameNotification, in: &cancellables)
        NotificationCenter.publisher(for: .name(UIResponder.keyboardDidChangeFrameNotification))
            .forward(to: keyboardDidChangeFrameNotification, in: &cancellables)

        Publishers.MergeMany(willShowNotification,
                             willHideNotification,
                             didShowNotification,
                             didHideNotification,
                             keyboardWillChangeFrameNotification,
                             keyboardDidChangeFrameNotification)
            .sink { [unowned self] notification in functions.map(\.value).forEach { $0(notification) } }
            .store(in: &cancellables)
    }
}

extension KeyboardObserver {
    /// Add a subscriber.
    /// - Parameters:
    ///   - action: the function that will be called if the keyboard's size is changing.
    /// - Note:
    /// To end the functionality, just call `.remove(id)` where the parameter is the return value of this function.
    /// - Returns:
    ///     The identifier of the subscriber.
    @discardableResult func isChanged(action: @escaping (_ notification: Notification) -> Void) -> UUID {
        let uuid = UUID()
        functions.updateValue(action, forKey: uuid)
        return uuid
    }

    /// Remove a subscriber.
    /// - Parameters:
    ///   - id: the subscriber that should be removed.
    func remove(id: UUID) {
        functions.removeValue(forKey: id)
    }
}
