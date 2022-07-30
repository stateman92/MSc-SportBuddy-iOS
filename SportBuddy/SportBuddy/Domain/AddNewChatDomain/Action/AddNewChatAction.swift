//
//  AddNewChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol AddNewChatAction {
    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher
}
