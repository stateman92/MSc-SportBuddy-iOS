//
//  HalfPositionType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum HalfPositionType: String, PositionType {
    // aroundi means the degrees between the forearm and the upper arm or calf and thigh
    case around0 = "  0"
    case around45 = " 45"
    case around90 = " 90"
    case around135 = "135"
    case around180 = "180"
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
