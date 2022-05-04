//
//  ViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import Combine
import Foundation

@propertyWrapper final class ViewModelState<State> {
    // MARK: Properties

    private let currentValueSubject: CurrentValueSubject<State, Never>
    var wrappedValue: State {
        didSet {
            currentValueSubject.send(wrappedValue)
        }
    }
    var projectedValue: ViewModelState<State> { self }

    // MARK: Initialization

    init(_ wrappedValue: State) {
        self.wrappedValue = wrappedValue
        currentValueSubject = .init(wrappedValue)
    }
}

// MARK: - Public methods

extension ViewModelState {
    var subject: AnyPublisher<State, Never> {
        currentValueSubject.eraseOnMain()
    }

    func sink(receiveValue: @escaping (State) -> Void) -> AnyCancellable {
        subject.sink(receiveValue: receiveValue)
    }

    func sink(receiveValue: @escaping (State) -> Void, store cancellables: inout Cancellables) {
        sink(receiveValue: receiveValue).store(in: &cancellables)
    }
}
