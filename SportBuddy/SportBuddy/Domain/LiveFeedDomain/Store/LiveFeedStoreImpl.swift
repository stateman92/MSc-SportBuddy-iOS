//
//  LiveFeedStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LiveFeedStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var liveFeedCache: LiveFeedCache
}

// MARK: - LiveFeedStore

extension LiveFeedStoreImpl: LiveFeedStore {
    func getLiveFeed() -> DomainStorePublisher<[LiveFeedResponseDTO]> {
        liveFeedCache.value().map(\.?.liveFeeds).autoEraseOnMain()
    }
}
