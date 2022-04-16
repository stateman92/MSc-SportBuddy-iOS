//
//  WebSocketServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

/// A protocol for managing the socket calls.
protocol WebSocketServiceProtocol: Initable {
    /// Initialize the service.
    /// - Parameters:
    ///   - autoConnect: whether to connect automatically on the service creation.
    init(autoConnect: Bool)

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
}

extension WebSocketServiceProtocol {
    /// Initialize the service with `true` autoconnect mode.
    init() {
        self.init(autoConnect: true)
    }
}
