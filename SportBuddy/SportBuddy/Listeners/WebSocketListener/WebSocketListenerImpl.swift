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
    @LazyInjected private var settingsCache: SettingsCache
    private var webSocketCancellable: AnyCancellable?
}

// MARK: - WebSocketListener

extension WebSocketListenerImpl: WebSocketListener {
    override func start() {
        super.start()
        settingsCache.value()
            .compactMap(\.?.batterySaving)
            .sink { [unowned self] saveBattery in
                if saveBattery {
                    webSocketService.disconnect()
                } else {
                    webSocketCancellable = webSocketService.reconnected
                        .combineLatest(userCache.value().compactMap(\.?.user.primaryId))
                        .sink { [unowned self] in webSocketService.send(WSConnectionDTO(clientIdentifier: $0.1)) }
                    webSocketService.connect()
                }
            }
            .store(in: &cancellables)
    }
}
