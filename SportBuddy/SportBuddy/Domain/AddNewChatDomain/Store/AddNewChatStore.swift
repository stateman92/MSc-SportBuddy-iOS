//
//  AddNewChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol AddNewChatStore {
    /// The searched users.
    var searchedUsers: DomainStorePublisher<[UserDTO]> { get }
    var chats: DomainStorePublisher<[ChatDTO]> { get }
}
