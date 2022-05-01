//
//  ChatsStoreProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

protocol ChatsStoreProtocol {
    func getChats() -> DomainStorePublisher<[ChatDTO]>
}
