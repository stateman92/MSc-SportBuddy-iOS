//
//  ExerciseConsumer.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

final class ExerciseConsumer {
    // MARK: Properties

    private var nextStateIndex = 0
    private var exercise: ExerciseModel?
}

extension ExerciseConsumer {
    func set(exercise: ExerciseModel) {
        self.exercise = exercise
    }

    func consume(characteristics: (Characteristics, Characteristics)) {
        guard var exercise else { return }
        let states = exercise.states
        if exercise.states.count >= nextStateIndex {
            // finished
            self.exercise = nil
        } else {
            if let nextState = states[safe: nextStateIndex] {
                if (nextState.armCharacteristics, nextState.legCharacteristics) == characteristics {
                    nextStateIndex += 1
                    print("Consumed state: \(characteristics.0.description)")
                    print("Consumed state: \(characteristics.1.description)")
                } else if let error = nextState.errors.first(for: characteristics.0, characteristics.1) {
                    print("Consumed error: \(error)")
                } else {
                    print("Unknown error")
                }
            }
            if states[safe: nextStateIndex] == nil {
                // finished
                self.exercise = nil
            } else if nextStateIndex % exercise.sequence.count == .zero {
                print("A sequence is recognized")
            }
        }
    }
}
