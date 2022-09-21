//
//  MockLiveFeedAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockLiveFeedAction: DomainImpl { }

// MARK: - LiveFeedAction

extension MockLiveFeedAction: LiveFeedAction {
    func sendText(message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}
