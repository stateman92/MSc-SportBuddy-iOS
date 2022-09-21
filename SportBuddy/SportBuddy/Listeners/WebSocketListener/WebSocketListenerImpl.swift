//
//  WebSocketListenerImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Combine

final class WebSocketListenerImpl: BaseListenerImpl {
    // MARK: Properties

    @LazyInjected private var webSocketService: WebSocketService
    @LazyInjected private var userCache: UserCache
}

// MARK: - WebSocketListener

extension WebSocketListenerImpl: WebSocketListener {
    override func start() {
        super.start()
        webSocketService.reconnected
            .combineLatest(userCache.value().compactMap(\.?.user.primaryId))
            .sink { [unowned self] in webSocketService.send(WSConnectionDTO(clientIdentifier: $0.1)) }
            .store(in: &cancellables)
    }
}
