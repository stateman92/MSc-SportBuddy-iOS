//
//  LoadingService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import Foundation

/// A class for managing the loading states.
final class LoadingService {
    // MARK: Properties

    private let currentState: CurrentValueSubject<LoadingState, Never>
    private let triggerSameValue: Bool
    private var cancellables = Cancellables()
    @LazyInjected private var loadingOverlayService: LoadingOverlayServiceProtocol

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameters:
    ///   - state: whether a loading indicator should be shown.
    ///   - triggerSameValue: whether the service indicates value changes from the same value.
    init(state: LoadingState, triggerSameValue: Bool) {
        self.currentState = .init(state)
        self.triggerSameValue = triggerSameValue
        bind(to: loadingOverlayService)
    }
}

// MARK: - LoadingServiceProtocol

extension LoadingService: LoadingServiceProtocol {
    /// A publisher which emits values when the application's loading state changes.
    var state: AnyPublisher<LoadingState, Never> {
        currentState.eraseToAnyPublisher()
    }

    /// Set the loading state of the application.
    /// - Parameter state: whether the loading should be shown.
    func set(state: LoadingState) {
        if currentState.value != state || (currentState.value == state && triggerSameValue) {
            currentState.send(state)
        }
    }

    /// Set the loading state to true, do some work in the closure, and then call the parameter in the closure.
    /// - Parameters:
    ///   - blocking: whether the loading should block the UI.
    ///   - during: the closure in which the work is being done.
    /// - Note: the closure marked with @escaping (for mocking).
    /// But it's guaranteed that it will be called synchronously.
    func loading(blocking: Bool, during closure: @escaping (@escaping () -> Void) -> Void) {
        set(state: blocking ? .fullScreenLoading : .nonBlockingLoading)
        closure { [weak self] in
            self?.set(state: .notLoading)
        }
    }

    /// Bind the state-handling to the view-handing.
    /// - Parameter service: the view-handling service to bind the service
    func bind(to service: LoadingOverlayServiceProtocol) {
        state
            .sink { service.set(state: $0) }
            .store(in: &cancellables)
    }
}
