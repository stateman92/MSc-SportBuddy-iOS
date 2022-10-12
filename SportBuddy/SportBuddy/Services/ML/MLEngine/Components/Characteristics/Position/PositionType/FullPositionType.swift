//
//  FullPositionType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum FullPositionType: String, PositionType {
    // i means the degrees between the upper arm and the shoulder-line (shoulder-line means the rightShoulder - leftShoulder line),
    // of between the thigh and the hip-line (hip-line means the leftHip - leftShoulder line)
    case around0 = "  0"
    case around45 = " 45"
    case around90 = " 90"
    case around135 = "135"
    case around180 = "180"
    case around225 = "225"
    case around270 = "270"
    case around315 = "315"
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
