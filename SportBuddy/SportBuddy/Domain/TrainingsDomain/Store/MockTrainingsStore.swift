//
//  MockTrainingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockTrainingsStore: DomainImpl { }

// MARK: - TrainingsStore

extension MockTrainingsStore: TrainingsStore {
    func getExercises() -> DomainStorePublisher<[ExerciseModel]> {
        .just(.mock).autoEraseOnMain()
    }
}
