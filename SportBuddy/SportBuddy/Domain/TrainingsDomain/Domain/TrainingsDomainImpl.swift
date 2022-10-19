//
//  TrainingsDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsDomainImpl {
    // MARK: Properties

    @LazyInjected var store: TrainingsStore
    @LazyInjected var action: TrainingsAction
}

// MARK: - TrainingsDomain

extension TrainingsDomainImpl: TrainingsDomain { }
