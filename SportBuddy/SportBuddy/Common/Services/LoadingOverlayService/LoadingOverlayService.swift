//
//  LoadingOverlayService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

/// A class that manages the view that shows the loading state.
final class LoadingOverlayService {
    private var isShowing = false

    init(isShowing: Bool) {
        set(isShowing: isShowing)
    }

    // MARK: Properties

    private let animationDuration = 0.25
    private let loadingOverlayView = LoadingOverlayView()
}

// MARK: - Public methods

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
