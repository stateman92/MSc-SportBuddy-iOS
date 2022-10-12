//
//  MLEngineImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

/// A class for interpreting the body recognition.
final class MLEngineImpl {
    // MARK: Properties

    private let exerciseConsumer = ExerciseConsumer()
}

// MARK: - MLEngine

extension MLEngineImpl: MLEngine {
    /// Set an exercise.
    /// - Parameters:
    ///   - exercise: the exercise.
    func set(exercise: ExerciseModel) {
    }

    /// Interpret the skeleton.
    /// - Parameters:
    ///   - skeleton: the skeleton.
    func interpret(skeleton: Skeleton) {
    }
}
