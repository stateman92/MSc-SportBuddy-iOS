//
//  LoadingOverlayServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

/// A class for showing the loading states.
final class LoadingOverlayServiceImpl {
    // MARK: Properties

    private var state: LoadingState = .notLoading
    private let animationDuration = 0.25
    private let loadingOverlayView = LoadingOverlayView()

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameter state: whether the loading indicator should be shown.
    init(state: LoadingState) {
        set(state: state)
    }
}

// MARK: - LoadingOverlayService

extension LoadingOverlayServiceImpl: LoadingOverlayService {
    /// Set the loading state.
    /// - Parameter state: whether the loading indicator should be shown.
    func set(state: LoadingState) {
        UIApplication.shared.setNetworkIndicator(isVisible: state.loading)
        UIApplication.shared.isIdleTimerDisabled = state.loading
        if state == .fullScreenLoading {
            show(on: UIApplication.keyWindow)
        } else {
            hide()
        }
    }
}

// MARK: - Private methods

extension LoadingOverlayServiceImpl {
    private func show(on view: UIView?) {
        guard let view = view, !state.loading else { return }
        state = .fullScreenLoading

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
        guard state.loading else { return }
        state = .notLoading

        UIView.animate(withDuration: animationDuration,
                       animations: { [self] in loadingOverlayView.alpha = .zero },
                       completion: { [self] _ in loadingOverlayView.removeFromSuperview() })
    }
}
