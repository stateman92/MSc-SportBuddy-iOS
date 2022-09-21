//
//  AddNewChatStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatStoreImpl: DomainImpl {
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
}

// MARK: - AddNewChatStore

extension AddNewChatStoreImpl: AddNewChatStore {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> {
        searchedUsersCache.clear()
        return searchedUsersCache.value().map(\.?.users).autoEraseOnMain()
    }
}
