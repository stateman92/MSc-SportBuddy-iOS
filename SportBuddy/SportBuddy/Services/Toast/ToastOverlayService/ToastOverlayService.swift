//
//  ToastOverlayService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

/// A protocol for showing the toasts.
protocol ToastOverlayService: AutoMockable {
    /// Initialize the service.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - message: the message of the toast
    ///   - type: the type of the toast.
    ///   - didRemove: the closure that will be called if the toast did dismiss.
    init(on view: UIView, message: String, type: ToastType, didRemove: @escaping () -> Void)

    /// Call to show the toast.
    func show()
}

extension ToastOverlayService {
    /// Initialize the service. By default `didRemove` is `{ }`.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - message: the message of the toast
    ///   - type: the type of the toast.
    init(on view: UIView, message: String, type: ToastType) {
        self.init(on: view, message: message, type: type, didRemove: { })
    }
}
