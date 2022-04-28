//
//  Chat+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

extension DependencyInjector {
    /// Register all the dependencies of the chat module.
    static func registerChatScreen() {
        resolver.register { ChatScreen() }
        resolver.register { ChatViewModel() }
    }
}
