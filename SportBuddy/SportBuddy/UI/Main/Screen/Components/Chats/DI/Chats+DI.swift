//
//  Chats+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the dependencies of the chats module.
    static func registerChatsScreen() {
        resolver.register { ChatsScreen() }
        resolver.register { ChatsViewModel() }

        registerAddNewChatScreen()
        registerChatScreen()
    }
}
