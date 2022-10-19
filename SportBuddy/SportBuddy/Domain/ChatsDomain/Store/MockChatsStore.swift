//
//  MockChatsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockChatsStore: DomainImpl { }

// MARK: - ChatsStore

extension MockChatsStore: ChatsStore {
    func getChats() -> DomainStorePublisher<[ChatDTO]> {
        .just(.mock).autoEraseOnMain()
    }
}
