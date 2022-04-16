//
//  UI+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the UI-related dependencies of the application.
    static func registerUI() {
        registerOnboardingScreen()
        registerLoginScreen()
        registerMainScreen()
    }
}
