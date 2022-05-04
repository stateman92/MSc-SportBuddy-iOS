//
//  AddNewChatStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol AddNewChatStoreProtocol {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> { get }
}
