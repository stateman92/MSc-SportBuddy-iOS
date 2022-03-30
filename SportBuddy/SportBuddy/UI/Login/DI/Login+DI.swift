//
//  Login+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import Foundation
import Resolver

extension DependencyInjector {
    static func registerLoginScreen() {
        resolver.register { LoginScreen() }
        resolver.register { LoginViewModel() }
    }
}
