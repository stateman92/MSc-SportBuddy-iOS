//
//  ChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Foundation

protocol ChatAction {
    func sendText(toChat: UUID, toRecipient: UUID, message: String) -> DomainActionPublisher
}
