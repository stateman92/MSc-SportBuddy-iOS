//
//  Groups+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the dependencies of the groups module.
    static func registerGroupsScreen() {
        resolver.register { GroupsScreen() }
        resolver.register { GroupsViewModel() }
    }
}
