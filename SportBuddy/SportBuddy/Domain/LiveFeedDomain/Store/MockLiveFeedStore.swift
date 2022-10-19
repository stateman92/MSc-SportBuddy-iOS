//
//  MockLiveFeedStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockLiveFeedStore: DomainImpl { }

// MARK: - LiveFeedStore

extension MockLiveFeedStore: LiveFeedStore {
    func getLiveFeed() -> DomainStorePublisher<[LiveFeedResponseDTO]> {
        .just(.mock).autoEraseOnMain()
    }
}
