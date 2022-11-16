//
//  ExerciseConsumer.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import AVFoundation
import Foundation

final class ExerciseConsumer {
    // MARK: Properties

    private var waiting = false
    private var nextStateIndex = 0
    private var exercise: ExerciseModel?
    @LazyInjected private var speechService: SpeechService
    @LazyInjected private var translatorService: TranslatorService
    @LazyInjected private var loggingService: LoggingService
    @LazyInjected private var timerService: TimerService
    @LazyInjected private var volumeService: VolumeService
    @LazyInjected private var toastService: ToastService

    // MARK: Initialization

    init() {
        setup()
    }
}

// MARK: - Setups

extension ExerciseConsumer {
    private func setup() {
        volumeService.set(volume: 0.5)
        speechService.read(text: .init(), language: language)
    }
}

// MARK: - Private methods

extension ExerciseConsumer {
    private var language: AVSpeechSynthesizer.Language {
        translatorService.preferredLanguage == .hu ? .hu : .en
    }
}

// MARK: - Public methods

extension ExerciseConsumer {
    func set(exercise: ExerciseModel) {
        self.exercise = exercise
    }

    func consume(skeleton: Skeleton) {
        guard !waiting,
              var exercise,
              let arm = skeleton.armPosition()?.characteristics,
              let leg = skeleton.legPosition()?.characteristics else { return }
        let states = exercise.states
        if states.count <= nextStateIndex {
            // finished
            self.exercise = nil
        } else {
            if let nextState = states[safe: nextStateIndex] {
                if (nextState.armCharacteristics, nextState.legCharacteristics) == (arm, leg) {
                    nextStateIndex += 1
                    speechService.read(text: L10n.Exercise.Successful.moment, language: language)
                    if nextStateIndex % exercise.sequence.count == .zero {
                        loggingService.default(message: "A sequence is recognized")
                        speechService.read(text: L10n.Exercise.Successful.sequence, language: language)
                    }
                    if states[safe: nextStateIndex] == nil {
                        // finished
                        self.exercise = nil
                        speechService.read(text: L10n.Exercise.Successful.exercise, language: language)
                        toastService.showToast(with: .init(message: L10n.Exercise.Successful.exercise, type: .success))
                    }
                    loggingService.default(message: "Consumed state: \(arm.description)")
                    loggingService.default(message: "Consumed state: \(leg.description)")
                    waiting = true
                    timerService.waitOnce(seconds: exercise.delay) { [weak self] in
                        self?.waiting = false
                    }
                } else if let error = nextState.errors.first(for: arm, leg) {
                    loggingService.default(message: "Consumed error: \(error)")
                    speechService.read(text: translatorService.translation(of: error.error), language: language)
                } else {
                    loggingService.default(message: "Unknown error")
                }
            }
        }
    }
}
