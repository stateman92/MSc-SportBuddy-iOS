//
//  DependencyInjector.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import Resolver

/// A thin layer between the application and the DI library (Resolver).
public struct DependencyInjector {
    // MARK: Properties

    static let resolver = Resolver()

    // MARK: Initialization

    private init() { }
}

// MARK: - Public methods

extension DependencyInjector {
    /// Resolve a given type of dependency.
    static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}
