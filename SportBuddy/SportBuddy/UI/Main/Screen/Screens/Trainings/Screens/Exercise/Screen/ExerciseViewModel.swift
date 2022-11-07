//
//  ExerciseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

final class ExerciseViewModel:
    BaseViewModel<ExerciseViewModelState, ExerciseViewModelCommand, ExerciseDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: ExerciseViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .set(exercise): set(exercise)
        }
    }
}

// MARK: - Commands

extension ExerciseViewModel {
    private func set(_ exercise: ExerciseModel) {
        sendState(.init(exercise: exercise))
    }
}
