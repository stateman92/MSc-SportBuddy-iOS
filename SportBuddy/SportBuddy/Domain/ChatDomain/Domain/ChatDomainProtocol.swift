//
//  ChatDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol ChatDomainProtocol: DomainProtocol {
    var store: ChatStoreProtocol { get }
    var action: ChatActionProtocol { get }
}
