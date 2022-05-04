//
//  LoadingOverlayServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

/// A protocol for showing the loading states.
protocol LoadingOverlayServiceProtocol: Initable, AutoMockable {
    /// Initialize the service.
    /// - Parameter state: whether the loading indicator should be shown.
    init(state: LoadingState)

    /// Set the loading state.
    /// - Parameter state: whether the loading indicator should be shown.
    func set(state: LoadingState)
}

extension LoadingOverlayServiceProtocol {
    /// Initialize the service. By default `state` is `.notLoading`.
    init() {
        self.init(state: .notLoading)
    }
}
