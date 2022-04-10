//
//  Onboarding+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import Resolver

extension DependencyInjector {
    /// Register all the dependencies of the onboarding module.
    static func registerOnboardingScreen() {
        resolver.register { OnboardingScreen() }
        resolver.register { OnboardingViewModel() }
    }
}
