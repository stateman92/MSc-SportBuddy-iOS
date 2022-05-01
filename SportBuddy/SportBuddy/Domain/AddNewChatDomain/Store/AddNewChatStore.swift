//
//  TrainingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatStore: Domain {
    @LazyInjected private var addNewChatCache: AddNewChatCache
}

extension AddNewChatStore: AddNewChatStoreProtocol {
    /// The searched users.
    var searchedUser: DomainStorePublisher<[UserDTO]> {
        addNewChatCache.autoEraseOnMain()
    }
}
