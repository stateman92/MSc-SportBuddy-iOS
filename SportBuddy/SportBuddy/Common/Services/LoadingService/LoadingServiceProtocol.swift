//
//  LoadingServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Combine

/// A protocol for managing the loading states.
protocol LoadingServiceProtocol: AutoMockable {
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

    func bind(to service: LoadingOverlayServiceProtocol)
}

extension LoadingServiceProtocol {
    init(isShowing: Bool = false, triggerSameValue: Bool = true) {
        self.init(isShowing: isShowing, triggerSameValue: triggerSameValue)
    }
}
