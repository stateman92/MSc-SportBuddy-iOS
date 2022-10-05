//
//  AddNewChatStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatStoreImpl: DomainImpl {
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
    @LazyInjected private var chatsCache: ChatsCache
}

// MARK: - AddNewChatStore

extension AddNewChatStoreImpl: AddNewChatStore {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> {
        searchedUsersCache.clear()
        return searchedUsersCache.value().map(\.?.users).autoEraseOnMain()
    }

    var chats: DomainStorePublisher<[ChatDTO]> {
        chatsCache.value().map(\.?.chats).map { $0 ?? .init() }.autoEraseOnMain()
    }
}
