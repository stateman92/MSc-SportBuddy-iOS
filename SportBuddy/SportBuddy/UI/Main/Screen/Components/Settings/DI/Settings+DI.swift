//
//  Settings+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the dependencies of the settings module.
    static func registerSettingsScreen() {
        resolver.register { SettingsScreen() }
        resolver.register { SettingsViewModel() }
    }
}
