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
    // swiftlint:disable cyclomatic_complexity line_length
    func first(for characteristics: Characteristics...) -> ExerciseError? {
        first { item in
            characteristics.contains {
                guard item.characteristics.type == $0.type else { return false }
                if let lhs = item.characteristics.firstHalfPositionType, let rhs = $0.firstHalfPositionType, lhs != rhs {
                    return false
                } else if item.characteristics.firstHalfPositionType != nil || $0.firstHalfPositionType != nil {
                    return false
                }
                if let lhs = item.characteristics.firstFullPositionType, let rhs = $0.firstFullPositionType, lhs != rhs {
                    return false
                } else if item.characteristics.firstFullPositionType != nil || $0.firstFullPositionType != nil {
                    return false
                }
                if let lhs = item.characteristics.secondFullPositionType, let rhs = $0.secondFullPositionType, lhs != rhs {
                    return false
                } else if item.characteristics.secondFullPositionType != nil || $0.secondFullPositionType != nil {
                    return false
                }
                if let lhs = item.characteristics.secondHalfPositionType, let rhs = $0.secondHalfPositionType, lhs != rhs {
                    return false
                } else if item.characteristics.secondHalfPositionType != nil || $0.secondHalfPositionType != nil {
                    return false
                }
                if let lhs = item.characteristics.distanceType, let rhs = $0.distanceType, lhs != rhs {
                    return false
                } else if item.characteristics.distanceType != nil || $0.distanceType != nil {
                    return false
                }
                return true
            }
        }
    }
    // swiftlint:enable cyclomatic_complexity line_length
}
