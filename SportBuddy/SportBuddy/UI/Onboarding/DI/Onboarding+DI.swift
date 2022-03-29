//
//  Onboarding+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import Foundation
import Resolver

extension DependencyInjector {
    static func registerOnboardingScreen() {
        resolver.register { OnboardingScreen() }
        resolver.register { OnboardingViewModel() }
    }
}
