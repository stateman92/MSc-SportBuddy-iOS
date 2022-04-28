//
//  ChatStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

protocol ChatStoreProtocol {
    func getChats() -> DomainStorePublisher<[ChatDTO]>

    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO>

    func getCreatedChatId() -> DomainStorePublisher<UUID>
}
