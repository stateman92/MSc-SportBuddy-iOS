//
//  AddNewChatActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatActionImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var searchedUsersCache: SearchedUsersCache
    @LazyInjected private var navigatorService: NavigatorService
}

// MARK: - AddNewChatAction

extension AddNewChatActionImpl: AddNewChatAction {
    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<[UserDTO]> in
            do {
                let results = try await ClientAPI.searchUserPost(name: searchTerm)
                searchedUsersCache.save(item: .init(users: results))
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<Void> in
            searchedUsersCache.save(item: .init(users: []))
            return .success(())
        }
    }
}
