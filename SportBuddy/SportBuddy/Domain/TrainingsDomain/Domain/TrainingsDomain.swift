//
//  TrainingsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol TrainingsDomain: Domain {
    var store: TrainingsStore { get }
    var action: TrainingsAction { get }
}
