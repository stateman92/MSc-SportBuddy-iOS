//
//  WebSocketService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

/// A protocol for managing the socket calls.
protocol WebSocketService: Initable {
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

    /// Notify if a message arrived.
    /// - Parameters:
    ///   - completion: the completion handler to the messages.
    func onReceive(completion: @escaping (String) -> Void)

    /// Notify if a connection is established.
    /// - Parameters:
    ///   - completion: the completion handler to the connection.
    func onReconnected(completion: @escaping () -> Void)
}

extension WebSocketService {
    /// Initialize the service. By default `autoConnect` is `true`, `autoReconnect` is `true`.
    init() {
        self.init(autoConnect: true, autoReconnect: true)
    }
}
