//
//  DistanceType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

enum DistanceType: String, PositionType, Codable, Equatable {
    // aroundi means that the two hands are i * (hip - shoulder) distance away
    case around0
    case around1
    case around2
    case around3
    case around4
    case aroundMinus1
    case aroundMinus2
    case aroundMinus3
    case aroundMinus4
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

extension DistanceType {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    // swiftlint:disable:next cyclomatic_complexity
    init(from dto: DistanceTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around1: self = .around1
        case .around2: self = .around2
        case .around3: self = .around3
        case .around4: self = .around4
        case .aroundminus1: self = .aroundMinus1
        case .aroundminus2: self = .aroundMinus2
        case .aroundminus3: self = .aroundMinus3
        case .aroundminus4: self = .aroundMinus4
        }
    }

    /// Get the object as a DTO object.
    var dto: DistanceTypeDTO {
        switch self {
        case .around0: return .around0
        case .around1: return .around1
        case .around2: return .around2
        case .around3: return .around3
        case .around4: return .around4
        case .aroundMinus1: return .aroundminus1
        case .aroundMinus2: return .aroundminus2
        case .aroundMinus3: return .aroundminus3
        case .aroundMinus4: return .aroundminus4
        }
    }
}
