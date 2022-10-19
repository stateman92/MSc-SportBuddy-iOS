//
//  Characteristics.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

struct Characteristics: Codable {
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

extension Characteristics {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: CharacteristicsDTO) {
        self.init(firstHalfPositionType: dto.firstHalfPositionType.map(HalfPositionType.init(from:)),
                  firstFullPositionType: dto.firstFullPositionType.map(FullPositionType.init(from:)),
                  secondFullPositionType: dto.secondFullPositionType.map(FullPositionType.init(from:)),
                  secondHalfPositionType: dto.secondHalfPositionType.map(HalfPositionType.init(from:)),
                  distanceType: dto.distanceType.map(DistanceType.init(from:)),
                  type: .init(from: dto.type))
    }

    /// Get the object as a DTO object.
    var dto: CharacteristicsDTO {
        .init(firstHalfPositionType: firstHalfPositionType?.dto,
              firstFullPositionType: firstFullPositionType?.dto,
              secondFullPositionType: secondFullPositionType?.dto,
              secondHalfPositionType: secondHalfPositionType?.dto,
              distanceType: distanceType?.dto,
              type: type.dto)
    }
}
