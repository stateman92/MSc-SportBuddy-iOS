//
//  ChatDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

final class ChatDomain: Domain {
    @LazyInjected private var chatCache: ChatCache
}

extension ChatDomain: ChatDomainProtocol { }
