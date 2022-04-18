//
//  WebSocketService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation
import Starscream

/// A class for managing the socket calls.
final class WebSocketService {
    // MARK: Properties

    private let socket: WebSocket
    @LazyInjected private var coderService: CoderServiceProtocol

    // MARK: Initialization

    init(autoConnect: Bool) {
        var request = URLRequest(url: URL(string: OpenAPIClientAPI.basePath)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        if autoConnect {
            connect()
        }
    }
}

// MARK: - WebSocketServiceProtocol

extension WebSocketService: WebSocketServiceProtocol {
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
        socket.onEvent = { event in
            switch event {
            case let .text(text): completion(text)
            default: break
            }
        }
    }
}
