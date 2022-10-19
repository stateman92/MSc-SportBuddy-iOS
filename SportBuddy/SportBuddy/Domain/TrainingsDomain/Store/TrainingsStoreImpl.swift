//
//  TrainingsStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var exerciseModelsCache: ExerciseModelsCache
}

// MARK: - TrainingsStore

extension TrainingsStoreImpl: TrainingsStore {
    func getExercises() -> DomainStorePublisher<[ExerciseModel]> {
        exerciseModelsCache.value().compactMap(\.?.exericesModels).autoEraseOnMain()
    }
}
