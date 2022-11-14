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
    @LazyInjected private var loggingService: LoggingService
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
                    loggingService.default(message: "Consumed state: \(arm.description)")
                    loggingService.default(message: "Consumed state: \(leg.description)")
                } else if let error = nextState.errors.first(for: arm, leg) {
                    loggingService.default(message: "Consumed error: \(error)")
                    speechService.read(text: translatorService.translation(of: error.error),
                                       language: translatorService.preferredLanguage == .hu ? .hu : .en)
                } else {
                    loggingService.default(message: "Unknown error")
                }
            }
            if states[safe: nextStateIndex] == nil {
                // finished
                self.exercise = nil
            } else if nextStateIndex % exercise.sequence.count == .zero {
                loggingService.default(message: "A sequence is recognized")
            }
        }
    }
}
