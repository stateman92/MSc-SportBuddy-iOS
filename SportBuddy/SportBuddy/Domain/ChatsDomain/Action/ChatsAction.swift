//
//  ChatsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsAction: Domain {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var webSocketService: WebSocketServiceProtocol
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var coderService: CoderServiceProtocol

    override init() {
        super.init()
        webSocketService.onReconnected { [unowned self] in
            if let userId = userCache.immediateValue?.primaryId {
                webSocketService.send(WSConnectionDTO(clientIdentifier: userId))
            }
        }
        webSocketService.onReceive { [unowned self] text in
            if let chat: ChatDTO = coderService.decode(string: text) {
                var chats = chatsCache.immediateValue ?? .init()
                chats.removeAll { $0.primaryId == chat.primaryId }
                chats.append(chat)
                chatsCache.save(item: chats)
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
