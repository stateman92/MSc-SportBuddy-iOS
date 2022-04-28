//
//  ChatActionProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Foundation

protocol ChatActionProtocol {
    func getChats() -> DomainActionPublisher
    func sendText(toRecipient: UUID, message: String) -> DomainActionPublisher
    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher
}

struct WebSocketMessage: Codable {
    let id: UUID?
    let sender: UUID
    let recipient: UUID
    let message: String
}
