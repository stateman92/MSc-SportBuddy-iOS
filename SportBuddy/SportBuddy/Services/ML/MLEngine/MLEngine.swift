//
//  MLEngine.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

/// A protocol for interpreting the body recognition.
protocol MLEngine: Initable, AutoMockable {
    /// Set an exercise.
    /// - Parameters:
    ///   - exercise: the exercise.
    func set(exercise: ExerciseModel)

    /// Interpret the skeleton.
    /// - Parameters:
    ///   - skeleton: the skeleton.
    func interpret(skeleton: Skeleton)
}

extension MLEngine {
    /// Interpret some bone endpoints.
    /// - Parameters:
    ///   - boneEndpoints: the bone endpoints.
    func interpret(boneEndpoints: [BoneEndpoint]) {
        interpret(skeleton: .init(from: boneEndpoints))
    }
}
