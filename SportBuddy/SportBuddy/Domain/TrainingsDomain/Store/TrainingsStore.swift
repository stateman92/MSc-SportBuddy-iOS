//
//  TrainingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol TrainingsStore {
    func getExercises() -> DomainStorePublisher<[ExerciseModel]>
}
