//
//  AddNewChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatAction: Domain {
    @LazyInjected private var addNewChatCache: AddNewChatCache
}

extension AddNewChatAction: AddNewChatActionProtocol {
    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<[UserDTO]> in
            do {
                let results = try await ClientAPI.searchUserPost(name: searchTerm)
                self?.addNewChatCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<Void> in
            self?.addNewChatCache.save(item: [])
            return .success(())
        }
    }
}
