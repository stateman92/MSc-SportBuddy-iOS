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
    @LazyInjected private var createdChatCache: CreatedChatCache
    @LazyInjected private var webSocketService: WebSocketServiceProtocol
    @LazyInjected private var coderService: CoderServiceProtocol

    override init() {
        super.init()
        _ = webSocketService
        webSocketService.onReceive { [weak self] text in
            guard let self = self,
                  let response: WebSocketMessage = self.coderService.decode(string: text),
                  var chats = self.chatCache.immediateValue,
                  var affectedChat = chats.first(where: { $0.primaryId == response.id }) else { return }
            affectedChat.chatEntries.append(.init(primaryId: .init(),
                                                  message: response.message,
                                                  timestamp: Int(Date().timeIntervalSince1970),
                                                  sender: response.sender,
                                                  deleted: false))
            chats.removeAll { $0.primaryId == response.id }
            chats.append(affectedChat)
            self.chatCache.save(item: chats)
        }
    }
}

extension ChatAction: ChatActionProtocol {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> Result<[ChatDTO], Error> in
            do {
                let results = try await ClientAPI.chatEntriesGet()
                chatCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    func sendText(toRecipient: UUID, message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> Result<Void, Error> in
            webSocketService.send(WebSocketMessage(id: nil,
                                                   sender: userCache.immediateValue!.primaryId,
                                                   recipient: toRecipient,
                                                   message: message))
            createdChatCache.clear()
            return .success(())
        }
    }

    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> Result<Void, Error> in
            webSocketService.send(WebSocketMessage(id: toChat,
                                                   sender: userCache.immediateValue!.primaryId,
                                                   recipient: toRecipient,
                                                   message: message))
            createdChatCache.save(item: toChat)
            return .success(())
        }
    }
}
