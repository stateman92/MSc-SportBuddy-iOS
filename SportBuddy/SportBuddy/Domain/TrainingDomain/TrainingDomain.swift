//
//  TrainingDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

final class TrainingDomain: Domain {
    @LazyInjected private var trainingCache: TrainingCache
}

extension TrainingDomain: TrainingDomainProtocol { }
