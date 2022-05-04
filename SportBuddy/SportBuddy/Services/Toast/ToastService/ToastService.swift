//
//  ToastService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

final class ToastService {
    // MARK: Properties

    private let view: UIView?
    private let overlayServiceType: ToastOverlayServiceProtocol.Type
    private var overlayService: ToastOverlayServiceProtocol?
    private var toastQueue = Queue<ToastItem>()

    // MARK: Initilization

    /// Initialize the service.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - overlayServiceType: the type of the overlay service.
    init(on view: UIView?, overlayServiceType: ToastOverlayServiceProtocol.Type) {
        self.view = view
        self.overlayServiceType = overlayServiceType
    }
}

// MARK: - ToastServiceProtocol

extension ToastService: ToastServiceProtocol {
    /// Show a toast.
    /// - Parameters:
    ///   - with: the toast.
    func showToast(with item: ToastItem) {
        if toastQueue.peek() == nil {
            showToast(with: item.message, type: item.type)
        }
        toastQueue.enqueue(item)
    }

    /// Toss the toasts.
    func invalidateQueue() {
        toastQueue = Queue<ToastItem>()
    }
}

// MARK: - Private methods

extension ToastService {
    private func showToast(with message: String, type: ToastType) {
        guard let view = view else { return }
        overlayService = overlayServiceType.init(on: view, message: message, type: type) { [weak self] in
            self?.toastQueue.dequeue()
            if let lastItem = self?.toastQueue.peek() {
                self?.showToast(with: lastItem.message, type: lastItem.type)
            }
        }
        overlayService?.show()
    }
}
