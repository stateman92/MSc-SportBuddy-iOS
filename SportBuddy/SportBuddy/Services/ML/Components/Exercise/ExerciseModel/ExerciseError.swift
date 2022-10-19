//
//  ExerciseError.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

struct ExerciseError: Codable, Equatable {
    let characteristics: Characteristics
    let error: String
}

extension [ExerciseError] {
    func first(for characteristics: Characteristics...) -> ExerciseError? {
        first { characteristics.contains($0.characteristics) }
    }
}
