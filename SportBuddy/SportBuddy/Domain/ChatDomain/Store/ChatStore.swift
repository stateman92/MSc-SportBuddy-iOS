//
//  ChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Foundation

protocol ChatStore {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO>
    func getUser() -> DomainStorePublisher<UserDTO>
    func getImage(for chatId: UUID) -> DomainStorePublisher<String>
    var immediateToken: UUID? { get }
}
