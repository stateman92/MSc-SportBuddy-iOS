//
//  LoadingServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Combine
import Foundation

/// A protocol for managing the loading states.
protocol LoadingServiceProtocol: AutoMockable, Initable {
    /// Initialize the service.
    /// - Parameters:
    ///   - isShowing: whether the loading indicator should be shown or not.
    ///   - triggerSameValue: whether the service indicates value changes from the same value.
    init(isShowing: Bool, triggerSameValue: Bool)

    /// A publisher which emits values when the application's loading state changes.
    var state: AnyPublisher<Bool, Never> { get }

    /// Set the loading state of the application.
    /// - Parameter showing: whether the loading should be shown.
    func setState(isShowing showing: Bool)

    /// Set the loading state to true, do some work in the closure, and then call the parameter in the closure.
    /// - Parameter during: the closure in which the work is being done.
    /// - Note: the closure marked with @escaping (for mocking).
    /// But it's guaranteed that it will be called synchronously.
    func loading(during closure: @escaping (@escaping () -> Void) -> Void)

    /// Bind the state-handling to the view-handing.
    /// - Parameter service: the view-handling service to bind the service
    func bind(to service: LoadingOverlayServiceProtocol)
}

extension LoadingServiceProtocol {
    /// Initialize the service. By default `isShowing` is `false` and `triggerSameValue` is `true`.
    init() {
        self.init(isShowing: false, triggerSameValue: true)
    }

    /// Set the loading state to `true`, do some work in the closure, and then call the parameter in the closure.
    /// - Parameter during: the closure in which the work is being done.
    func loading(during closure: @escaping () async -> Void) {
        loading { finished in
            Task {
                await closure()
                dispatchToMain {
                    finished()
                }
            }
        }
    }
}
