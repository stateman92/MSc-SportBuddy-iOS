//
//  ChatsDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsDomainImpl {
    // MARK: Properties

    @LazyInjected var store: ChatsStore
    @LazyInjected var action: ChatsAction
}

// MARK: - ChatsDomain

extension ChatsDomainImpl: ChatsDomain { }
