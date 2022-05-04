//
//  MockAddNewChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockAddNewChatStore: Domain { }

extension MockAddNewChatStore: AddNewChatStoreProtocol {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> {
        Just(.mock).autoEraseOnMain()
    }
}
