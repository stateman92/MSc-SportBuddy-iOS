//
//  ChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatAction: Domain {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var webSocketService: WebSocketServiceProtocol
}

extension ChatAction: ChatActionProtocol {
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
