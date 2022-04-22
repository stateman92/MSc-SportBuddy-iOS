//
//  ChatStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class ChatStore: Domain {
    @LazyInjected private var chatCache: ChatCache
}

extension ChatStore: ChatStoreProtocol { }
