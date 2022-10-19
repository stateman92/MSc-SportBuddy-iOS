//
//  ExerciseModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

struct ExerciseModel: Codable, Equatable {
    let id: UUID
    let sequence: [ExerciseMoment]
    let sequenceCount: Int
    let delay: TimeInterval
    let videoId: String
    let name: String
    let details: String?

    lazy var states: [ExerciseMoment] = {
        var states = [ExerciseMoment]()
        (0..<sequenceCount).forEach { _ in
            sequence.forEach {
                states.append($0)
            }
        }
        return states
    }()
}
