//
//  LoadingOverlayService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

/// A protocol for showing the loading states.
protocol LoadingOverlayService: Initable, AutoMockable {
    /// Initialize the service.
    /// - Parameter state: whether the loading indicator should be shown.
    init(state: LoadingState)

    /// Set the loading state.
    /// - Parameter state: whether the loading indicator should be shown.
    func set(state: LoadingState)
}

extension LoadingOverlayService {
    /// Initialize the service. By default `state` is `.notLoading`.
    init() {
        self.init(state: .notLoading)
    }
}
