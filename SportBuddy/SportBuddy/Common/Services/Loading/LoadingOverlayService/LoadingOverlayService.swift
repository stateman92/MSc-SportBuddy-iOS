//
//  LoadingOverlayService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

/// A class for showing the loading states.
final class LoadingOverlayService {
    // MARK: Properties

    private var isShowing = false
    private let animationDuration = 0.25
    private let loadingOverlayView = LoadingOverlayView()

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameter isShowing: whether the loading indicator should be shown or not.
    init(isShowing: Bool) {
        set(isShowing: isShowing)
    }
}

// MARK: - LoadingOverlayServiceProtocol

extension LoadingOverlayService: LoadingOverlayServiceProtocol {
    /// Set the loading state.
    /// - Parameter isShowing: whether the loading indicator should be shown or not.
    func set(isShowing: Bool) {
        UIApplication.shared.setNetworkIndicator(isVisible: isShowing)
        UIApplication.shared.isIdleTimerDisabled = isShowing
        if isShowing {
            show(on: UIApplication.keyWindow)
        } else {
            hide()
        }
    }
}

// MARK: - Private methods

extension LoadingOverlayService {
    private func show(on view: UIView?) {
        guard let view = view, !isShowing else { return }
        isShowing = true

        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        loadingOverlayView.then {
            $0.removeFromSuperview()
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            $0.alpha = .zero
        }

        UIView.animate(withDuration: animationDuration) { [self] in
            loadingOverlayView.alpha = 1
        }
    }

    private func hide() {
        guard isShowing else { return }
        isShowing = false

        UIView.animate(withDuration: animationDuration,
                       animations: { [self] in loadingOverlayView.alpha = .zero },
                       completion: { [self] _ in loadingOverlayView.removeFromSuperview() })
    }
}
