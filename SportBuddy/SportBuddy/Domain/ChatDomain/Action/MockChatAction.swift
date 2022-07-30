//
//  MockChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine
import Foundation

final class MockChatAction: DomainImpl { }

// MARK: - ChatAction

extension MockChatAction: ChatAction {
    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}
