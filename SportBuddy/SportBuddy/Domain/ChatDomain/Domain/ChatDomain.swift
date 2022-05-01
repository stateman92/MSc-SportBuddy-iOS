//
//  ChatDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatDomain {
    @LazyInjected var store: ChatStoreProtocol
    @LazyInjected var action: ChatActionProtocol
}

extension ChatDomain: ChatDomainProtocol { }
