//
//  TrainingsViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct TrainingsViewModelState {
    let exerciseModels: [ExerciseModel]
}

extension TrainingsViewModelState: Initable {
    init() {
        self.init(exerciseModels: .init())
    }
}

extension TrainingsViewModelState: Equatable { }
