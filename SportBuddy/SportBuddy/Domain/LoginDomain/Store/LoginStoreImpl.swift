//
//  LoginStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

final class LoginStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
}

// MARK: - LoginStore

extension LoginStoreImpl: LoginStore {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> {
        userCache.value().map(\.?.user).autoEraseOnMain()
    }

    /// The token.
    var token: DomainStorePublisher<UUID?> {
        tokenCache.value().map(\.?.token).autoEraseOnMain()
    }

    var immediateToken: UUID? {
        tokenCache.immediateValue?.token
    }
}
