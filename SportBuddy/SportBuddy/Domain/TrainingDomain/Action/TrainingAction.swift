//
//  TrainingAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class TrainingAction: Domain {
    @LazyInjected private var trainingCache: TrainingCache
}

extension TrainingAction: TrainingActionProtocol { }
