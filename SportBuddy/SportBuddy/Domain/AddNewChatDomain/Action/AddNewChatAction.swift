//
//  AddNewChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatAction: Domain {
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
    @LazyInjected private var navigatorService: NavigatorServiceProtocol
}

extension AddNewChatAction: AddNewChatActionProtocol {
    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[UserDTO]> in
            do {
                let results = try await ClientAPI.searchUserPost(name: searchTerm)
                searchedUsersCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<Void> in
            searchedUsersCache.save(item: [])
            return .success(())
        }
    }
}
