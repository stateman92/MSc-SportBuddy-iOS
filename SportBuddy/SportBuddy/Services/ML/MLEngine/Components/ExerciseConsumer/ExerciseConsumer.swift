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
    @LazyInjected private var speechService: SpeechService
    @LazyInjected private var translatorService: TranslatorService
}

// MARK: - Public methods

extension ExerciseConsumer {
    func set(exercise: ExerciseModel) {
        self.exercise = exercise
    }

    func consume(skeleton: Skeleton) {
        guard var exercise,
              let arm = skeleton.armPosition()?.characteristics,
              let leg = skeleton.legPosition()?.characteristics else { return }
        let states = exercise.states
        if exercise.states.count >= nextStateIndex {
            // finished
            self.exercise = nil
        } else {
            if let nextState = states[safe: nextStateIndex] {
                if (nextState.armCharacteristics, nextState.legCharacteristics) == (arm, leg) {
                    nextStateIndex += 1
                    print("Consumed state: \(arm.description)")
                    print("Consumed state: \(leg.description)")
                } else if let error = nextState.errors.first(for: arm, leg) {
                    print("Consumed error: \(error)")
                    speechService.read(text: translatorService.translation(of: error.error),
                                       language: translatorService.preferredLanguage == .hu ? .hu : .en)
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
