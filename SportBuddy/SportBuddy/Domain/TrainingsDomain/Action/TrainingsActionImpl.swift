//
//  TrainingsActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsActionImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var exerciseModelsCache: ExerciseModelsCache
}

// MARK: - TrainingsAction

extension TrainingsActionImpl: TrainingsAction {
    func refreshExerciseModels() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<Void> in
            do {
                let results = try await BackendAPI.exerciseModelsGet()
                exerciseModelsCache.save(
                    item: .init(
                        exericesModels: results.map {
                            .init(
                                id: $0.id,
                                sequence: $0.sequence.map {
                                    .init(
                                        armCharacteristics: .init(from: $0.armCharacteristics),
                                        legCharacteristics: .init(from: $0.legCharacteristics),
                                        errors: $0.errors.map {
                                            .init(characteristics: .init(from: $0.characteristics),
                                                  error: $0.error)
                                        })
                                },
                                sequenceCount: $0.sequenceCount,
                                delay: $0.delay,
                                videoId: $0.videoId,
                                name: $0.name,
                                details: $0.details
                            )
                        }))
                return .success(())
            } catch {
                return .failure(error)
            }
        }
    }
}
