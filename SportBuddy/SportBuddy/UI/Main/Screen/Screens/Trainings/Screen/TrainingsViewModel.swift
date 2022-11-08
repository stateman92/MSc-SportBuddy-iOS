//
//  TrainingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation

final class TrainingsViewModel:
    BaseViewModel<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl> {
    // MARK: Properties

    @LazyInjected private var loadingService: LoadingService

    // MARK: - Command

    override func receiveCommand(_ command: TrainingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .select(id): select(id)
        case .viewDidAppear: viewDidAppear()
        }
    }
}

// MARK: - Setups

extension TrainingsViewModel {
    override func setup() {
        super.setup()
        store.getExercises()
            .sink { [unowned self] in sendState(.init(exerciseModels: $0)) }
            .store(in: &cancellables)
    }
}

// MARK: - Commands

extension TrainingsViewModel {
    private func select(_ id: UUID) {
        guard let exercise = viewState.value.exerciseModels.first(where: { $0.id == id }) else { return }
        loadingService.set(state: .fullScreenLoading)
        DispatchQueue.main.async {
            let screen = self.navigatorService.present(ExerciseScreen.self)
            screen.sendCommand(.set(exercise: exercise))
        }
    }

    private func viewDidAppear() {
        action.refreshExerciseModels().sink().store(in: &cancellables)
    }
}
