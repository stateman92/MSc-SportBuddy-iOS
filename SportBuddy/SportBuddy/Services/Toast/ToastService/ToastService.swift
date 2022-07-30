//
//  ToastService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit.UIView

protocol ToastService: AutoMockable {
    /// Initialize the service.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - overlayServiceType: the type of the overlay service.
    init(on view: UIView?, overlayServiceType: ToastOverlayService.Type)

    /// Show a toast.
    /// - Parameters:
    ///   - with: the toast.
    func showToast(with item: ToastItem)

    /// Toss the toasts.
    func invalidateQueue()
}

extension ToastService {
    /// Initialize the service. By default `overlayServiceType` is `ToastOverlayServiceImpl.self`.
    /// - Parameters:
    ///   - on: the parent view.
    init(on view: UIView?) {
        self.init(on: view, overlayServiceType: ToastOverlayServiceImpl.self)
    }
}
