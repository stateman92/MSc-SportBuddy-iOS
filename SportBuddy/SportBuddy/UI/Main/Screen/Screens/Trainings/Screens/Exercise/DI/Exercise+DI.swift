//
//  Exercise+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import Foundation

extension DependencyInjector {
    /// Register all the dependencies of the chat module.
    static func registerExerciseScreen() {
        resolver.register { ExerciseScreen() }
        resolver.register { ExerciseViewModel() }
    }
}
