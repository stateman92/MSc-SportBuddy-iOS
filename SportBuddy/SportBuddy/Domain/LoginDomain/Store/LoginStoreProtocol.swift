//
//  LoginStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

protocol LoginStoreProtocol {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> { get }

    /// The token.
    var token: DomainStorePublisher<UUID?> { get }

    var immediateToken: UUID? { get }
}
