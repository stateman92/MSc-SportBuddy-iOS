//
//  LoadingService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine

/// Service for showing loading indicator during network calls.
final class LoadingService {
    private let isShowing: CurrentValueSubject<Bool, Never>
    private let triggerSameValue: Bool
    private var cancellables = Set<AnyCancellable>()

    init(isShowing: Bool, triggerSameValue: Bool) {
        self.isShowing = .init(isShowing)
        self.triggerSameValue = triggerSameValue
    }
}

extension LoadingService: LoadingServiceProtocol {
    /// A publisher which emits values when the application's loading state changes.
    var state: AnyPublisher<Bool, Never> {
        isShowing.eraseToAnyPublisher()
    }

    /// Set the loading state of the application.
    /// - Parameter showing: whether the loading should be shown.
    func setState(isShowing showing: Bool) {
        if isShowing.value != showing || (isShowing.value == showing && triggerSameValue) {
            isShowing.send(showing)
        }
    }

    /// Set the loading state to true, do some work in the closure, and then call the parameter in the closure.
    /// - Parameter during: the closure in which the work is being done.
    /// - Note: the closure marked with @escaping (for mocking).
    /// But it's guaranteed that it will be called synchronously.
    func loading(during closure: @escaping (@escaping () -> Void) -> Void) {
        setState(isShowing: true)
        closure { [weak self] in
            self?.setState(isShowing: false)
        }
    }

    func bind(to service: LoadingOverlayServiceProtocol) {
        state
            .sink { service.set(isShowing: $0) }
            .store(in: &cancellables)
    }
}
