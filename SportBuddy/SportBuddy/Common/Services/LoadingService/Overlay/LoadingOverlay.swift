//
//  LoadingOverlay.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// A class that manages the view that shows the loading state.
final class LoadingOverlay {
    /// Singleton object.
    static let shared = LoadingOverlay()
    private init() { }

    // MARK: Properties

    private let animationDuration = 0.25
    private let loadingOverlayView = LoadingOverlayView()
}

// MARK: - Public methods

extension LoadingOverlay {
    /// Set the loading state.
    /// - Parameter isShowing: whether the loading indicator should be shown or not.
    func set(isShowing: Bool) {
        if isShowing {
            UIApplication.shared.setNetworkIndicator(isVisible: true)
            show(on: UIApplication.keyWindow)
        } else {
            UIApplication.shared.setNetworkIndicator(isVisible: false)
            hide()
        }
    }
}

// MARK: - Private methods

extension LoadingOverlay {
    private func show(on view: UIView?) {
        guard let view = view else { return }

        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        UIApplication.shared.isIdleTimerDisabled = true

        loadingOverlayView.then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }

        loadingOverlayView.alpha = .zero
        UIView.animate(withDuration: animationDuration) { [self] in
            loadingOverlayView.alpha = 1
        }
    }

    private func hide() {
        UIApplication.shared.isIdleTimerDisabled = false

        UIView.animate(withDuration: animationDuration,
                       animations: { [self] in loadingOverlayView.alpha = .zero },
                       completion: { [self] _ in loadingOverlayView.removeFromSuperview() })
    }
}
