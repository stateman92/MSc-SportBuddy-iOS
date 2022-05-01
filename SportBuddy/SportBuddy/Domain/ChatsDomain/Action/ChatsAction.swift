//
//  ChatsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsAction: Domain {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var webSocketService: WebSocketServiceProtocol
    @LazyInjected private var loginCache: LoginCache
    @LazyInjected private var coderService: CoderServiceProtocol

    override init() {
        super.init()
        webSocketService.onReconnected { [weak self] in
            if let userId = self?.loginCache.immediateValue?.primaryId {
                self?.webSocketService.send(WSConnectionDTO(clientIdentifier: userId))
            }
        }
        webSocketService.onReceive { [weak self] text in
            guard let self = self else { return }
            if let chat: ChatDTO = self.coderService.decode(string: text) {
                var chats = self.chatsCache.immediateValue ?? .init()
                chats.removeAll { $0.primaryId == chat.primaryId }
                chats.append(chat)
                self.chatsCache.save(item: chats)
            }
        }
    }
}

extension ChatsAction: ChatsActionProtocol {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[ChatDTO]> in
            do {
                let results = try await ClientAPI.chatEntriesGet()
                chatsCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }
}
