//
//  ExerciseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

final class ExerciseViewModel:
    BaseViewModel<ExerciseViewModelState, ExerciseViewModelCommand, ExerciseDomainImpl> {
    // MARK: Properties

    @LazyInjected private var mlEngine: MLEngine

    // MARK: - Command

    override func receiveCommand(_ command: ExerciseViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .set(exercise): set(exercise)
        case let .detect(skeleton): detect(skeleton)
        }
    }
}

// MARK: - Commands

extension ExerciseViewModel {
    private func set(_ exercise: ExerciseModel) {
        sendState(.init(exercise: exercise))
        mlEngine.set(exercise: exercise)
    }

    private func detect(_ skeleton: Skeleton) {
        mlEngine.interpret(skeleton: skeleton)
    }
}
