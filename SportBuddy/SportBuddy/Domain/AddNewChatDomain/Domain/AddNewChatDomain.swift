//
//  AddNewChatDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatDomain {
    @LazyInjected var store: AddNewChatStoreProtocol
    @LazyInjected var action: AddNewChatActionProtocol
}

extension AddNewChatDomain: AddNewChatDomainProtocol { }
