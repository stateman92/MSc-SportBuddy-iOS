//
//  MockChatsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockChatsStore: Domain { }

extension MockChatsStore: ChatsStoreProtocol {
    func getChats() -> DomainStorePublisher<[ChatDTO]> {
        Just(.mock).autoEraseOnMain()
    }
}
