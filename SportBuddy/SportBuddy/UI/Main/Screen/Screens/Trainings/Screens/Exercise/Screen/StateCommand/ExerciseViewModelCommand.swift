//
//  ExerciseViewModelCommand.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

enum ExerciseViewModelCommand {
    case set(exercise: ExerciseModel)
    case detect(skeleton: Skeleton)
}
