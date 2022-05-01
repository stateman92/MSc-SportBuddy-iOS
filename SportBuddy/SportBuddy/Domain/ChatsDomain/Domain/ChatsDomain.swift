//
//  ChatsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsDomain {
    @LazyInjected var store: ChatsStoreProtocol
    @LazyInjected var action: ChatsActionProtocol
}

extension ChatsDomain: ChatsDomainProtocol { }
