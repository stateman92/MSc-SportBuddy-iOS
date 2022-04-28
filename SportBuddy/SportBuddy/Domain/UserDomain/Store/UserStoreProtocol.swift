//
//  UserStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

protocol UserStoreProtocol {
    /// The current user.
    var currentUser: DomainStorePublisher<UserDTO> { get }

    /// The token.
    var token: DomainStorePublisher<UUID?> { get }

    /// The searched users.
    var searchedUser: DomainStorePublisher<[UserDTO]> { get }
}
