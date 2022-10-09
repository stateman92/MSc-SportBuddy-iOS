//
//  ChatActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatActionImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var webSocketService: WebSocketService
}

// MARK: - ChatAction

extension ChatActionImpl: ChatAction {
    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
            guard let userId = userCache.immediateValue?.user.primaryId else {
                assertionFailure("User's id didn't find!")
                return .success(())
            }
            webSocketService.send(ChatDTO(chatEntries: [.init(primaryId: .init(),
                                                              message: message,
                                                              timestamp: Date().secondsSince1970,
                                                              sender: userId,
                                                              deleted: false)],
                                          image: .init(),
                                          primaryId: toChat,
                                          users: [userId, toRecipient],
                                          otherParty: .init()))
            return .success(())
        }
    }
}
