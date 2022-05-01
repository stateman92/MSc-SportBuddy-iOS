//
//  TrainingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class TrainingsStore: Domain {
    @LazyInjected private var trainingsCache: TrainingsCache
}

extension TrainingsStore: TrainingsStoreProtocol { }
