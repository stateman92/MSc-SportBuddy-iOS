//
//  TrainingsDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol TrainingsDomainProtocol: DomainProtocol {
    var store: TrainingsStoreProtocol { get }
    var action: TrainingsActionProtocol { get }
}
