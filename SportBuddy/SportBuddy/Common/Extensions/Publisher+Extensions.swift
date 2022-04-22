//
//  Publisher+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine

extension Publisher where Failure == Never {
    /// Sink the given publisher's values.
    /// - Parameters:
    ///   - in: the `Cancellables` to store the publisher in.
    ///   - receiveValue: this method will be called if a new value arrived.
    func sink(in set: inout Cancellables, receiveValue: @escaping ((Output) -> Void)) {
        sink(receiveValue: receiveValue).store(in: &set)
    }

    /// Forward the events to the given subject.
    /// - Parameters:
    ///   - to: the given subject.
    /// - Returns:
    ///     The `AnyCancellable`.
    func forward(to subject: PassthroughSubject<Output, Failure>) -> AnyCancellable {
        sink { subject.send($0) }
    }

    /// Forward the events to the given subject.
    /// - Parameters:
    ///   - to: the given subject.
    ///   - in: the `Cancellables` to store the publisher in.
    func forward(to subject: PassthroughSubject<Output, Failure>, in set: inout Cancellables) {
        forward(to: subject).store(in: &set)
    }
}

extension Publisher {
    /// Sink the given publisher's values.
    /// - Parameters:
    ///   - receiveError: sink the errors.
    ///   - receiveCompletion: sink the completion.
    ///   - receiveValue: sink the success values.
    /// - Returns:
    ///     The `AnyCancellable`.
    func sink(receiveError: @escaping (Error) -> Void = { _ in },
              receiveCompletion: @escaping () -> Void = { },
              receiveValue: @escaping (Output) -> Void = { _ in }) -> AnyCancellable {
        sink { completion in
            switch completion {
            case let .failure(error): receiveError(error)
            case .finished: receiveCompletion()
            }
        } receiveValue: {
            receiveValue($0)
        }
    }
}
