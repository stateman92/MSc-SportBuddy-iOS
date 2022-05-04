//
//  TrainingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatStore: Domain {
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
}

extension AddNewChatStore: AddNewChatStoreProtocol {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> {
        searchedUsersCache.clear()
        return searchedUsersCache.autoEraseOnMain()
    }
}
