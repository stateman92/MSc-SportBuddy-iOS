//
//  LoadingOverlayServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

/// A protocol for showing the loading states.
protocol LoadingOverlayServiceProtocol: Initable, AutoMockable {
    /// Initialize the service.
    /// - Parameter isShowing: whether the loading indicator should be shown or not.
    init(isShowing: Bool)

    /// Set the loading state.
    /// - Parameter isShowing: whether the loading indicator should be shown or not.
    func set(isShowing: Bool)
}

extension LoadingOverlayServiceProtocol {
    /// Initialize the service. By default `isShowing` is `false`.
    init() {
        self.init(isShowing: false)
    }
}
