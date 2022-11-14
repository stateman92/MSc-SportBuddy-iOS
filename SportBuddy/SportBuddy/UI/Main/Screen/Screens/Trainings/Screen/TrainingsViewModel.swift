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
            .map {
                if $0.count > 1 {
                    let half = $0.count / 2
                    let left = $0[.zero ..< half]
                    let right = $0[half ..< $0.count]
                    return [Array(left), Array(right)]
                } else {
                    return [$0]
                }
            }
            .sink { [unowned self] in sendState(.init(exerciseModels: $0)) }
            .store(in: &cancellables)
    }
}

// MARK: - Commands

extension TrainingsViewModel {
    private func select(_ id: UUID) {
        guard let model = viewState.value.exerciseModels.flatMap({ $0 }).first(where: { $0.id == id }) else { return }
        loadingService.set(state: .fullScreenLoading)
        DispatchQueue.main.async {
            let screen = self.navigatorService.present(ExerciseScreen.self)
            screen.sendCommand(.set(exercise: model))
        }
    }

    private func viewDidAppear() {
        action.refreshExerciseModels().sink().store(in: &cancellables)
    }
}
