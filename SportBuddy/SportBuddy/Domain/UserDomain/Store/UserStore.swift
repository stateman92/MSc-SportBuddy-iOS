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
}

extension UserStore: UserStoreProtocol {
    /// The current user.
    var currentUser: AnyPublisher<UserDTO, Never> {
        userCache.value().compactMap { $0 }.eraseToAnyPublisher()
    }
}
