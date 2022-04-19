//
//  ToastHandlingService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

final class ToastHandlingService {
    // MARK: Properties

    private let window: UIView
    private var errorMessageQueue = Queue<ToastItem>()

    // MARK: Initilization

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public methods

extension ToastHandlingService: ToastHandlingServiceProtocol {
    func showToast(with item: ToastItem) {
        if errorMessageQueue.peek() == nil {
            showToast(with: item.message, type: item.type)
        }
        errorMessageQueue.enqueue(item)
    }

    func invalidateQueue() {
        errorMessageQueue = Queue<ToastItem>()
    }
}

// MARK: - Private methods

extension ToastHandlingService {
    private func showToast(with message: String, type: ToastType) {
        Toast(view: window, message: message, type: type) { [weak self] in
            self?.errorMessageQueue.dequeue()
            if let lastItem = self?.errorMessageQueue.peek() {
                self?.showToast(with: lastItem.message, type: lastItem.type)
            }
        }.show()
    }
}
