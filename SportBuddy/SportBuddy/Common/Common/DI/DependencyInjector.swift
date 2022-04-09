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

        registerServices()
    }

    /// Resolve a given type of dependency.
    static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}

extension DependencyInjector {
    private static func registerServices() {
        resolver
            .register { LoadingOverlayService() }
            .implements(LoadingOverlayServiceProtocol.self)
            .scope(.application)

        resolver
            .register { LoadingService() }
            .implements(LoadingServiceProtocol.self)
            .scope(.application)

        resolver
            .register { MLService() }
            .implements(MLServiceProtocol.self)
            .scope(.application)

        resolver
            .register { NavigatorService(rootViewController: resolve() as OnboardingScreen) }
            .implements(NavigatorServiceProtocol.self)
            .scope(.application)

        resolver
            .register { NetworkService() }
            .implements(NetworkServiceProtocol.self)
            .scope(.application)

        resolver
            .register { SettingsService() }
            .implements(SettingsServiceProtocol.self)
            .scope(.application)
    }
}
