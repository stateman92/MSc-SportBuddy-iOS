//
//  MockAddNewChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockAddNewChatStore: DomainImpl { }

// MARK: - AddNewChatStore

extension MockAddNewChatStore: AddNewChatStore {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> {
        .just(.mock).autoEraseOnMain()
    }

    var chats: DomainStorePublisher<[ChatDTO]> {
        .just(.mock).autoEraseOnMain()
    }
}
