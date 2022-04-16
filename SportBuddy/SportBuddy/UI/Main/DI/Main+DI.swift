//
//  Main+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the dependencies of the main module.
    static func registerMainScreen() {
        resolver.register { MainScreen() }
        resolver.register { MainViewModel() }
        resolver.register { MainScreenTabs() }

        registerTabs()
    }
}

extension DependencyInjector {
    /// Register the tabs of the main module.
    private static func registerTabs() {
        registerGroupsScreen()
        registerChatsScreen()
        registerTrainingsScreen()
        registerSettingsScreen()
    }
}
