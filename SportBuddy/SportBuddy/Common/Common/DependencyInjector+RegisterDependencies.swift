//
//  DependencyInjector+RegisterDependencies.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

extension DependencyInjector {
    /// Register all the dependencies of the application.
    static func registerDependencies() {
        registerServices()
        registerDomains()
        registerUI()
    }
}
