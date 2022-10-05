//
//  WebSocketService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine

/// A protocol for managing the socket calls.
protocol WebSocketService: Initable {
    /// Notify if a message arrived.
    var receivedText: AnyPublisher<String, Never> { get }

    /// Notify if a connection is established.
    var reconnected: AnyPublisher<Void, Never> { get }

    /// Initialize the service.
    /// - Parameters:
    ///   - autoConnect: whether to connect automatically on the service creation.
    ///   - autoReconnect: whether to connect automatically on disconnection.
    init(autoConnect: Bool, autoReconnect: Bool)

    /// Connect to the remote service.
    func connect()

    /// Disconnect from the remote service.
    func disconnect()

    /// Send on object to the service.
    /// - Parameters:
    ///   - object: the object.
    func send<T>(_ object: T) where T: Codable
}

extension WebSocketService {
    /// Initialize the service. By default `autoConnect` is `false`, `autoReconnect` is `false`.
    init() {
        self.init(autoConnect: false, autoReconnect: false)
    }
}
