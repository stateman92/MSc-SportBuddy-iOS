//
//  AddNewChatDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class AddNewChatDomainImpl {
    @LazyInjected var store: AddNewChatStore
    @LazyInjected var action: AddNewChatAction
}

// MARK: - AddNewChatDomain

extension AddNewChatDomainImpl: AddNewChatDomain { }
