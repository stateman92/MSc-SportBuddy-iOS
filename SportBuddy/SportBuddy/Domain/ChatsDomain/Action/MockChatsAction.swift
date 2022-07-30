//
//  MockChatsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockChatsAction: DomainImpl { }

// MARK: - ChatsAction

extension MockChatsAction: ChatsAction {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<[ChatDTO]> in
            await wait()
            return .success(.mock)
        }
    }
}
