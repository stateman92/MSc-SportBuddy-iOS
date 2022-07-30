//
//  GroupsStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsStoreImpl: DomainImpl {
    @LazyInjected private var chatsCache: ChatsCache
}

// MARK: - ChatsStore

extension ChatsStoreImpl: ChatsStore {
    func getChats() -> DomainStorePublisher<[ChatDTO]> {
        chatsCache.value().autoEraseOnMain()
    }
}
