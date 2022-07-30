//
//  MockChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine
import Foundation

final class MockChatStore: DomainImpl { }

// MARK: - ChatStore

extension MockChatStore: ChatStore {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO> {
        Just(.mock).autoEraseOnMain()
    }

    var immediateToken: UUID? {
        .mock
    }
}
