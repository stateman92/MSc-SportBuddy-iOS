//
//  DistanceType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum DistanceType: String, PositionType {
    // aroundi means that the two hands are i * (hip - shoulder) distance away
    case around0 = "0"
    case around1 = "1"
    case around2 = "2"
    case around3 = "3"
    case around4 = "4"
    case aroundMinus1 = "-1"
    case aroundMinus2 = "-2"
    case aroundMinus3 = "-3"
    case aroundMinus4 = "-4"
}

// MARK: - Initialization

extension DistanceType {
    // swiftlint:disable:next cyclomatic_complexity
    init(distance: CGFloat) {
        switch distance {
        case ...(-3.5): self = .aroundMinus4
        case -3.5...(-2.5): self = .aroundMinus3
        case -2.5...(-1.5): self = .aroundMinus2
        case -1.5...(-0.5): self = .aroundMinus1
        case -0.5...0.5: self = .around0
        case 0.5...1.5: self = .around1
        case 1.5...2.5: self = .around2
        case 2.5...3.5: self = .around3
        case 3.5...: self = .around4
        default: self = .around0
        }
    }
}
