//
//  AddNewChat+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

extension DependencyInjector {
    /// Register all the dependencies of the add new chat module.
    static func registerAddNewChatScreen() {
        resolver.register { AddNewChatScreen() }
        resolver.register { AddNewChatViewModel() }
    }
}
