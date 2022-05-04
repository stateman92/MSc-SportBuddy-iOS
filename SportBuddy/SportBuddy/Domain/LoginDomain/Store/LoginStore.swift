//
//  LoginStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

final class LoginStore: Domain {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
}

extension LoginStore: LoginStoreProtocol {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> {
        userCache.autoEraseOnMain()
    }

    /// The token.
    var token: DomainStorePublisher<UUID?> {
        tokenCache.autoEraseOnMain()
    }

    var immediateToken: UUID? {
        tokenCache.immediateValue
    }
}
