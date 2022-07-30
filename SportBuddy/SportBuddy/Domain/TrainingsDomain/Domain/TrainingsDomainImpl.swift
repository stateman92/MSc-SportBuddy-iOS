//
//  TrainingsDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsDomainImpl {
    @LazyInjected var store: TrainingsStore
    @LazyInjected var action: TrainingsAction
}

// MARK: - TrainingsAction

extension TrainingsDomainImpl: TrainingsDomain { }
