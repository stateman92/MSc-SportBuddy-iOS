//
//  MockAddNewChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockAddNewChatAction: DomainImpl { }

// MARK: - AddNewChatAction

extension MockAddNewChatAction: AddNewChatAction {
    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<[UserDTO]> in
            await wait()
            return .success(.mock)
        }
    }

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}
