//
//  HalfPositionType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum HalfPositionType: String, PositionType, Codable, Equatable {
    // aroundi means the degrees between the forearm and the upper arm or calf and thigh
    case around0
    case around45
    case around90
    case around135
    case around180
}

// MARK: - Initialization

extension HalfPositionType {
    init(degrees: CGFloat) {
        switch degrees.truncatingPositiveRemainder(dividingBy: 180) {
        case ...22.5: self = .around0
        case 22.5...67.5: self = .around45
        case 67.5...112.5: self = .around90
        case 112.5...157.5: self = .around135
        case 157.5...: self = .around180
        default: self = .around0
        }
    }
}

extension HalfPositionType {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: HalfPositionTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around45: self = .around45
        case .around90: self = .around90
        case .around135: self = .around135
        case .around180: self = .around180
        }
    }

    /// Get the object as a DTO object.
    var dto: HalfPositionTypeDTO {
        switch self {
        case .around0: return .around0
        case .around45: return .around45
        case .around90: return .around90
        case .around135: return .around135
        case .around180: return .around180
        }
    }
}
