//
//  LegPosition.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics
import SwiftUI

struct LegPosition {
    let rightCalf: CGFloat
    let rightLegAngle: Angle
    let rightThigh: CGFloat
    let rightHipAngle: Angle

    let leftHipAngle: Angle
    let leftThigh: CGFloat
    let leftLegAngle: Angle
    let leftCalf: CGFloat

    let feetDistance: CGFloat
}

extension LegPosition {
    private var rightCalfPositionType: HalfPositionType {
        .init(degrees: rightLegAngle.degrees)
    }

    private var rightHipPositionType: FullPositionType {
        .init(degrees: rightHipAngle.degrees)
    }

    private var leftHipPositionType: FullPositionType {
        .init(degrees: leftHipAngle.degrees)
    }

    private var leftCalfPositionType: HalfPositionType {
        .init(degrees: leftLegAngle.degrees)
    }

    var feetDistanceType: DistanceType {
        .init(distance: feetDistance)
    }

    var leftFeetHipDistance: DistanceType {
        .init(distance: leftCalf + leftThigh)
    }

    var rightFeetHipDistance: DistanceType {
        .init(distance: rightCalf + rightThigh)
    }

    var characteristics: Characteristics {
        Characteristics(firstHalfPositionType: rightCalfPositionType,
                        firstFullPositionType: rightHipPositionType,
                        secondFullPositionType: leftHipPositionType,
                        secondHalfPositionType: leftCalfPositionType,
                        distanceType: feetDistanceType,
                        type: .legs)
    }
}

// MARK: - Equatable

extension LegPosition: Equatable {
    static func == (lhs: LegPosition, rhs: LegPosition) -> Bool {
        lhs.characteristics == rhs.characteristics
    }
}

// MARK: - Hashable

extension LegPosition: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rightCalfPositionType)
        hasher.combine(rightHipPositionType)
        hasher.combine(leftHipPositionType)
        hasher.combine(leftCalfPositionType)
        hasher.combine(feetDistanceType)
    }
}

// MARK: - CustomStringConvertible

extension LegPosition: CustomStringConvertible {
    var description: String {
        "right leg: \(rightCalfPositionType.rawValue), " +
        "right hip: \(rightHipPositionType.rawValue), " +
        "left hip: \(leftHipPositionType.rawValue), " +
        "left leg: \(leftCalfPositionType.rawValue), " +
        "feet: \(feetDistanceType.rawValue)"
    }
}
