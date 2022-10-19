//
//  ExerciseMoment.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

struct ExerciseMoment: Codable, Equatable {
    let armCharacteristics: Characteristics
    let legCharacteristics: Characteristics
    let errors: [ExerciseError]
}
