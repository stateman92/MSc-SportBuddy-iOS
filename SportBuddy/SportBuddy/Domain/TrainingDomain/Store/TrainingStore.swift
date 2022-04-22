//
//  TrainingStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class TrainingStore: Domain {
    @LazyInjected private var trainingCache: TrainingCache
}

extension TrainingStore: TrainingStoreProtocol { }
