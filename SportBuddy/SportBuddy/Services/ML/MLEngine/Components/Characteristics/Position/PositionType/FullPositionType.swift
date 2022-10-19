//
//  FullPositionType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum FullPositionType: String, PositionType, Codable, Equatable {
    // i means the degrees between the upper arm and the shoulder-line (shoulder-line means the rightShoulder - leftShoulder line),
    // of between the thigh and the hip-line (hip-line means the leftHip - leftShoulder line)
    case around0
    case around45
    case around90
    case around135
    case around180
    case around225
    case around270
    case around315
}

// MARK: - Initialization

extension FullPositionType {
    // swiftlint:disable:next cyclomatic_complexity
    init(degrees: CGFloat) {
        switch degrees.truncatingPositiveRemainder(dividingBy: 360) {
        case ...22.5: self = .around0
        case 22.5...67.5: self = .around45
        case 67.5...112.5: self = .around90
        case 112.5...157.5: self = .around135
        case 157.5...202.5: self = .around180
        case 202.5...247.5: self = .around225
        case 247.5...292.5: self = .around270
        case 292.5...337.5: self = .around315
        case 337.5...: self = .around0
        default: self = .around0
        }
    }
}

extension FullPositionType {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: FullPositionTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around45: self = .around45
        case .around90: self = .around90
        case .around135: self = .around135
        case .around180: self = .around180
        case .around225: self = .around225
        case .around270: self = .around270
        case .around315: self = .around315
        }
    }

    /// Get the object as a DTO object.
    var dto: FullPositionTypeDTO {
        switch self {
        case .around0: return .around0
        case .around45: return .around45
        case .around90: return .around90
        case .around135: return .around135
        case .around180: return .around180
        case .around225: return .around225
        case .around270: return .around270
        case .around315: return .around315
        }
    }
}
