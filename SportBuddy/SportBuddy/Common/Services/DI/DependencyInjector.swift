//
//  DependencyInjector.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import Resolver
import UIKit

/// A thin layer between the application and the DI library (Resolver).
public struct DependencyInjector {
    static let resolver = Resolver()

    private init() { }
}

extension DependencyInjector {
    /// Register all the dependencies of the application.
    static func registerDependencies() {
        registerOnboardingScreen()
        registerLoginScreen()

        resolver.register { UINavigationController(rootViewController: resolve() as OnboardingScreen) }.scope(.shared)
    }

    /// Resolve a given type of dependency.
    static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}