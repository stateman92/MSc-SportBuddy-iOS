//
//  TrainingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class TrainingsViewModel:
    BaseViewModel<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl> {
    // MARK: Properties

    @LazyInjected private var mlEngine: MLEngine

    // MARK: - Command

    override func receiveCommand(_ command: TrainingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .interpret(skeleton): interpret(skeleton)
        }
    }
}

// MARK: - Commands

extension TrainingsViewModel {
    private func interpret(_ skeleton: Skeleton) {
        mlEngine.interpret(skeleton: skeleton)
    }
}
