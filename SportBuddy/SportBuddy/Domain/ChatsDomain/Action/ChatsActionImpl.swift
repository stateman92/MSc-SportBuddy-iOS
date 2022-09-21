//
//  ChatsActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsActionImpl: DomainImpl {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var webSocketService: WebSocketService
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var coderService: CoderService

    override init() {
        super.init()
        webSocketService.receivedText
            .compactMap { [unowned self] text -> ChatDTO? in coderService.decode(string: text) }
            .sink { [unowned self] chat in
                var chats = (chatsCache.immediateValue ?? .init(chats: [])).chats
                chats.removeAll { $0.primaryId == chat.primaryId }
                chats.append(chat)
                chatsCache.save(item: .init(chats: chats))
            }
            .store(in: &cancellables)
    }
}

// MARK: - ChatsAction

extension ChatsActionImpl: ChatsAction {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[ChatDTO]> in
            do {
                let results = try await ClientAPI.chatEntriesGet()
                chatsCache.save(item: .init(chats: results))
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }
}
