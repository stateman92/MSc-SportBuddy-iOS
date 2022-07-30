//
//  WebSocketServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation
import Starscream

/// A class for managing the socket calls.
final class WebSocketServiceImpl {
    // MARK: Properties

    private let socket: WebSocket
    private let autoReconnect: Bool
    @LazyInjected private var coderService: CoderService
    private var receiveText: (String) -> Void = { _ in }
    private var reconnected: () -> Void = { }

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameters:
    ///   - autoConnect: whether to connect automatically on the service creation.
    ///   - autoReconnect: whether to connect automatically on disconnection.
    init(autoConnect: Bool, autoReconnect: Bool) {
        let url = OpenAPIClientAPI.basePath.replacingOccurrences(of: "http", with: "ws")
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        self.autoReconnect = autoReconnect
        if autoConnect {
            connect()
        }
        socket.delegate = self
    }
}

// MARK: - WebSocketService

extension WebSocketServiceImpl: WebSocketService {
    /// Connect to the remote service.
    func connect() {
        socket.connect()
    }

    /// Disconnect from the remote service.
    func disconnect() {
        socket.disconnect()
    }

    /// Send on object to the service.
    /// - Parameters:
    ///   - object: the object.
    func send<T>(_ object: T) where T: Codable {
        guard let string: String = coderService.encode(object: object) else { return }
        socket.write(string: string)
    }

    /// Notify if a message arrived.
    /// - Parameters:
    ///   - completion: the completion handler to the messages.
    func onReceive(completion: @escaping (String) -> Void) {
        receiveText = completion
    }

    /// Notify if a connection is established.
    /// - Parameters:
    ///   - completion: the completion handler to the connection.
    func onReconnected(completion: @escaping () -> Void) {
        reconnected = completion
    }
}

// MARK: - WebSocketDelegate

extension WebSocketServiceImpl: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case let .text(text): receiveText(text)
        case .disconnected, .cancelled:
            if autoReconnect {
                connect()
            }
        case .connected:
            reconnected()
        default: break
        }
    }
}
