//
//  AddNewChatDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol AddNewChatDomainProtocol: DomainProtocol {
    var store: AddNewChatStoreProtocol { get }
    var action: AddNewChatActionProtocol { get }
}
