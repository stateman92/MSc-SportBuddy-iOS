//
//  ExerciseDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

protocol ExerciseDomain: Domain {
    var store: ExerciseStore { get }
    var action: ExerciseAction { get }
}
