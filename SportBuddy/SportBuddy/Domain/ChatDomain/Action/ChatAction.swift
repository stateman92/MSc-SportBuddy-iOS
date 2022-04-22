//
//  ChatAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class ChatAction: Domain {
    @LazyInjected private var chatCache: ChatCache
}

extension ChatAction: ChatActionProtocol { }
