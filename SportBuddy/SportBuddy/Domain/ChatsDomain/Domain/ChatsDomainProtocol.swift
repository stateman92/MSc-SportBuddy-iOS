//
//  ChatsDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol ChatsDomainProtocol: DomainProtocol {
    var store: ChatsStoreProtocol { get }
    var action: ChatsActionProtocol { get }
}
