//
//  LoadingService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Combine
import Foundation

/// A protocol for managing the loading states.
protocol LoadingService: Initable, AutoMockable {
    /// Initialize the service.
    /// - Parameters:
    ///   - state: whether a loading indicator should be shown.
    ///   - triggerSameValue: whether the service indicates value changes from the same value.
    init(state: LoadingState, triggerSameValue: Bool)

    /// A publisher which emits values when the application's loading state changes.
    var state: AnyPublisher<LoadingState, Never> { get }

    /// Set the loading state of the application.
    /// - Parameter state: whether the loading should be shown.
    func set(state: LoadingState)

    /// Set the loading state to true, do some work in the closure, and then call the parameter in the closure.
    /// - Parameters:
    ///   - blocking: whether the loading should block the UI.
    ///   - during: the closure in which the work is being done.
    /// - Note: the closure marked with @escaping (for mocking).
    /// But it's guaranteed that it will be called synchronously.
    func loading(blocking: Bool, during closure: @escaping (@escaping () -> Void) -> Void)

    /// Bind the state-handling to the view-handing.
    /// - Parameter service: the view-handling service to bind the service
    func bind(to service: LoadingOverlayService)
}

extension LoadingService {
    /// Initialize the service. By default `state` is `.notLoading` and `triggerSameValue` is `true`.
    init() {
        self.init(state: .notLoading, triggerSameValue: true)
    }

    /// Set the loading state to `true`, do some work in the closure, and then call the parameter in the closure.
    /// - Parameters:
    ///   - blocking: whether the loading should block the UI. By default `true`.
    ///   - during: the closure in which the work is being done.
    func loading(blocking: Bool = true, during closure: @escaping () async -> Void) {
        loading(blocking: blocking) { finished in
            Task {
                await closure()
                dispatchToMain {
                    finished()
                }
            }
        }
    }
}
