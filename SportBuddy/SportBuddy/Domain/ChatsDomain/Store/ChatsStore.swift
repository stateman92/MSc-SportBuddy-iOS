//
//  GroupsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsStore: Domain {
    @LazyInjected private var chatsCache: ChatsCache
}

extension ChatsStore: ChatsStoreProtocol {
    func getChats() -> DomainStorePublisher<[ChatDTO]> {
        chatsCache.value().autoEraseOnMain()
    }
}
