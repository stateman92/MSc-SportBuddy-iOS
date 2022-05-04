//
//  MockChatsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockChatsAction: Domain { }

extension MockChatsAction: ChatsActionProtocol {
    func getChats() -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<[ChatDTO]> in
            await wait()
            return .success(.mock)
        }
    }
}
