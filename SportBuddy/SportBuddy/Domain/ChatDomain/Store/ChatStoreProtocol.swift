//
//  ChatStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Foundation

protocol ChatStoreProtocol {
    func getChat(id: UUID) -> DomainStorePublisher<ChatDTO>
    var immediateToken: UUID? { get }
}
