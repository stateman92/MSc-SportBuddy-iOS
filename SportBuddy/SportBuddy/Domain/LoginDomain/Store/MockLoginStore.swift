//
//  MockLoginStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine
import Foundation

final class MockLoginStore: DomainImpl { }

// MARK: - LoginStore

extension MockLoginStore: LoginStore {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> {
        Just(.mock).autoEraseOnMain()
    }

    /// The token.
    var token: DomainStorePublisher<UUID?> {
        Just(nil).autoEraseOnMain()
    }

    var immediateToken: UUID? {
        nil
    }
}
