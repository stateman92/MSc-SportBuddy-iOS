//
//  Characteristics.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

struct Characteristics {
    enum CharacteristicsType {
        case arms
        case legs
    }

    var firstHalfPositionType: HalfPositionType?
    var firstFullPositionType: FullPositionType?
    var secondFullPositionType: FullPositionType?
    var secondHalfPositionType: HalfPositionType?
    var distanceType: DistanceType?

    var type: CharacteristicsType
}

// MARK: - Equatable

extension Characteristics: Equatable {
    static func == (lhs: Characteristics, rhs: Characteristics) -> Bool {
        guard lhs.type == rhs.type else { return false }
        if let lhs = lhs.firstHalfPositionType, let rhs = rhs.firstHalfPositionType, lhs != rhs {
            return false
        }
        if let lhs = lhs.firstFullPositionType, let rhs = rhs.firstFullPositionType, lhs != rhs {
            return false
        }
        if let lhs = lhs.secondFullPositionType, let rhs = rhs.secondFullPositionType, lhs != rhs {
            return false
        }
        if let lhs = lhs.secondHalfPositionType, let rhs = rhs.secondHalfPositionType, lhs != rhs {
            return false
        }
        if let lhs = lhs.distanceType, let rhs = rhs.distanceType, lhs != rhs {
            return false
        }
        return true
    }
}

// MARK: - Hashable

extension Characteristics: Hashable {
    func hash(into hasher: inout Hasher) {
        let first = firstHalfPositionType?.rawValue ?? .init()
        let second = firstFullPositionType?.rawValue ?? .init()
        let third = secondFullPositionType?.rawValue ?? .init()
        let fourth = secondHalfPositionType?.rawValue ?? .init()
        let fifth = distanceType?.rawValue ?? .init()
        hasher.combine(first + second + third + fourth + fifth)
    }
}

// MARK: - CustomStringConvertible

extension Characteristics: CustomStringConvertible {
    var description: String {
        if type == .arms {
            return """
                Arms: right forearm and upperarm angle:     \(firstHalfPositionType?.rawValue ?? "NA") degrees,
                      right upperarm and shoulder angle:    \(firstFullPositionType?.rawValue ?? "NA") degrees,
                      left shoulder and upperarm angle:     \(secondFullPositionType?.rawValue ?? "NA") degrees,
                      left upperarm and forearm angle:      \(secondHalfPositionType?.rawValue ?? "NA") degrees,
                      distance between the two hands:       \(distanceType?.rawValue ?? "NA") * hip-shoulder distance.
                """
        } else {
            return """
                Leg: right calf and thigh angle:            \(firstHalfPositionType?.rawValue ?? "NA") degrees,
                     right thigh and hip angle:             \(firstFullPositionType?.rawValue ?? "NA") degrees,
                     left hip and thigh angle:              \(secondFullPositionType?.rawValue ?? "NA") degrees,
                     left thigh and calf angle:             \(secondHalfPositionType?.rawValue ?? "NA") degrees,
                     distance between the two feet:         \(distanceType?.rawValue ?? "NA") * hip-shoulder distance.
                """
        }
    }
}
