//
//  Trainings+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the dependencies of the trainings module.
    static func registerTrainingsScreen() {
        resolver.register { TrainingsScreen() }
        resolver.register { TrainingsViewModel() }
    }
}
