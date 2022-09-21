//
//  LiveFeedDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LiveFeedDomainImpl {
    @LazyInjected var store: LiveFeedStore
    @LazyInjected var action: LiveFeedAction
}

// MARK: - LiveFeedDomain

extension LiveFeedDomainImpl: LiveFeedDomain { }
