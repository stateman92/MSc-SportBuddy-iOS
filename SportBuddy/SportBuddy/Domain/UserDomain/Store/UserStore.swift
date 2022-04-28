//
//  UserStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class UserStore: Domain {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
}

extension UserStore: UserStoreProtocol {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> {
        userCache.autoEraseOnMain()
    }

    /// The token.
    var token: DomainStorePublisher<UUID?> {
        tokenCache.autoEraseOnMain()
    }

    /// The searched users.
    var searchedUser: DomainStorePublisher<[UserDTO]> {
        searchedUsersCache.autoEraseOnMain()
    }
}
