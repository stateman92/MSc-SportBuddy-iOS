//
//  ChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class ChatStore: Domain {
    @LazyInjected private var chatCache: ChatCache
}

extension ChatStore: ChatStoreProtocol {
    func getChats() -> DomainStorePublisher<[ChatDTO]> {
        chatCache.value().autoEraseOnMain()
    }

    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO> {
        chatCache.value().map { $0?.first { $0.primaryId == id } }.autoEraseOnMain()
    }
}
