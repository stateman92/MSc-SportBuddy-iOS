//
//  TrainingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation

final class TrainingsViewModel:
    BaseViewModel<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: TrainingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .select(id): select(id)
        }
    }
}

// MARK: - Setups

extension TrainingsViewModel {
    override func setup() {
        super.setup()
        action.refreshExerciseModels().sink().store(in: &cancellables)
        store.getExercises()
            .sink { [unowned self] in sendState(.init(exerciseModels: $0)) }
            .store(in: &cancellables)
    }
}

// MARK: - Commands

extension TrainingsViewModel {
    private func select(_ id: UUID) {
        navigatorService.present(ExerciseScreen.self)
    }
}
