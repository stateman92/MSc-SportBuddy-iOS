//
//  TrainingsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsDomain {
    @LazyInjected var store: TrainingsStoreProtocol
    @LazyInjected var action: TrainingsActionProtocol
}

extension TrainingsDomain: TrainingsDomainProtocol { }
