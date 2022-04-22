//
//  UserStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine

protocol UserStoreProtocol {
    /// The current user.
    var currentUser: AnyPublisher<UserDTO, Never> { get }
}
