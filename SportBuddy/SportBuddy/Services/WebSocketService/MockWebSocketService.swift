//
//  MockWebSocketService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import Combine
import Foundation

/// A mock class for managing the socket calls.
final class MockWebSocketService {
    // MARK: Initialization

    /// Initialize the service.
    /// - Parameters:
    ///   - autoConnect: whether to connect automatically on the service creation.
    ///   - autoReconnect: whether to connect automatically on disconnection.
    init(autoConnect: Bool, autoReconnect: Bool) { }
}

// MARK: - WebSocketService

extension MockWebSocketService: WebSocketService {
    /// Notify if a message arrived.
    var receivedText: AnyPublisher<String, Never> {
        Empty().eraseOnMain().eraseToAnyPublisher()
    }

    /// Notify if a connection is established.
    var reconnected: AnyPublisher<Void, Never> {
        Empty().eraseOnMain()
    }

    /// Connect to the remote service.
    func connect() { }

    /// Disconnect from the remote service.
    func disconnect() { }

    /// Send on object to the service.
    /// - Parameters:
    ///   - object: the object.
    func send<T>(_ object: T) where T: Codable { }
}
