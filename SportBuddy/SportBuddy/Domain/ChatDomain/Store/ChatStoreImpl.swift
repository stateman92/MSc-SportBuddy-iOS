//
//  ChatStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatStoreImpl: DomainImpl {
    @LazyInjected private var chatsCache: ChatsCache
    @LazyInjected private var tokenCache: TokenCache
}

// MARK: - ChatStore

extension ChatStoreImpl: ChatStore {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO> {
        chatsCache.value().map { $0?.first { $0.primaryId == id } }.autoEraseOnMain()
    }

    var immediateToken: UUID? {
        tokenCache.immediateValue
    }
}
