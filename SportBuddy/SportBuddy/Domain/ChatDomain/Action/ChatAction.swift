//
//  ChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatAction: Domain {
    @LazyInjected private var chatCache: ChatCache
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var webSocketService: WebSocketServiceProtocol
    @LazyInjected private var coderService: CoderServiceProtocol

    override init() {
        super.init()
        webSocketService.onReconnected { [weak self] in
            if let userId = self?.userCache.immediateValue?.primaryId {
                self?.webSocketService.send(WSConnectionDTO(clientIdentifier: userId))
            }
        }
        webSocketService.onReceive { [weak self] text in
            guard let self = self else { return }
            if let chat: ChatDTO = self.coderService.decode(string: text) {
                var chats = self.chatCache.immediateValue ?? .init()
                chats.removeAll { $0.primaryId == chat.primaryId }
                chats.append(chat)
                self.chatCache.save(item: chats)
            }
        }
    }
}

extension ChatAction: ChatActionProtocol {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[ChatDTO]> in
            do {
                let results = try await ClientAPI.chatEntriesGet()
                chatCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
            guard let userId = userCache.immediateValue?.primaryId else {
                assertionFailure("User's id didn't find!")
                return .success(())
            }
            webSocketService.send(ChatDTO(primaryId: toChat,
                                          users: [userId, toRecipient],
                                          chatEntries: [.init(primaryId: .init(),
                                                              message: message,
                                                              timestamp: Date().secondsSince1970,
                                                              sender: userId,
                                                              deleted: false)],
                                          image: .init()))
            return .success(())
        }
    }
}
