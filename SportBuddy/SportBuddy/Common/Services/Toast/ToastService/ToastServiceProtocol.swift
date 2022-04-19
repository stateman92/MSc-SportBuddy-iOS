//
//  ToastServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit.UIView

protocol ToastServiceProtocol: AutoMockable {
    /// Initialize the service.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - overlayServiceType: the type of the overlay service.
    init(on view: UIView?, overlayServiceType: ToastOverlayServiceProtocol.Type)

    /// Show a toast.
    /// - Parameters:
    ///   - with: the toast.
    func showToast(with item: ToastItem)

    /// Toss the toasts.
    func invalidateQueue()
}

extension ToastServiceProtocol {
    /// Initialize the service. By default `overlayServiceType` is `ToastOverlayService.self`.
    /// - Parameters:
    ///   - on: the parent view.
    init(on view: UIView?) {
        self.init(on: view, overlayServiceType: ToastOverlayService.self)
    }
}
