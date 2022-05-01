//
//  ChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatStore: Domain {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var tokenCache: TokenCache
}

extension ChatStore: ChatStoreProtocol {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO> {
        chatsCache.value().map { $0?.first { $0.primaryId == id } }.autoEraseOnMain()
    }

    var immediateToken: UUID? {
        tokenCache.immediateValue
    }
}
