//
//  Login+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

extension DependencyInjector {
    /// Register all the dependencies of the login module.
    static func registerLoginScreen() {
        resolver.register { LoginScreen() }
        resolver.register { LoginViewModel() }
    }
}
