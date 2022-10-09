//
//  ChatDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatDomainImpl {
    // MARK: Properties

    @LazyInjected var store: ChatStore
    @LazyInjected var action: ChatAction
}

// MARK: - ChatDomain

extension ChatDomainImpl: ChatDomain { }
