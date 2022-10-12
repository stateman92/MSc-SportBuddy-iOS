//
//  ArmPosition.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics
import SwiftUI

struct ArmPosition {
    let rightForeArm: CGFloat
    let rightArmAngle: Angle
    let rightUpperArm: CGFloat
    let rightShoulderAngle: Angle

    let leftShoulderAngle: Angle
    let leftForeArm: CGFloat
    let leftArmAngle: Angle
    let leftUpperArm: CGFloat

    let handsDistance: CGFloat
}

extension ArmPosition {
    private var rightArmPositionType: HalfPositionType {
        .init(degrees: rightArmAngle.degrees)
    }

    private var rightShoulderPositionType: FullPositionType {
        .init(degrees: rightShoulderAngle.degrees)
    }

    private var leftShoulderPositionType: FullPositionType {
        .init(degrees: leftShoulderAngle.degrees)
    }

    private var leftArmPositionType: HalfPositionType {
        .init(degrees: leftArmAngle.degrees)
    }

    var handDistanceType: DistanceType {
        .init(distance: handsDistance)
    }

    var leftHandShoulderDistance: DistanceType {
        .init(distance: leftForeArm + leftUpperArm)
    }

    var rightHandShoulderDistance: DistanceType {
        .init(distance: rightForeArm + rightUpperArm)
    }

    var characteristics: Characteristics {
        Characteristics(firstHalfPositionType: rightArmPositionType,
                        firstFullPositionType: rightShoulderPositionType,
                        secondFullPositionType: leftShoulderPositionType,
                        secondHalfPositionType: leftArmPositionType,
                        distanceType: handDistanceType,
                        type: .arms)
    }
}

// MARK: - Equatable

extension ArmPosition: Equatable {
    static func == (lhs: ArmPosition, rhs: ArmPosition) -> Bool {
        lhs.characteristics == rhs.characteristics
    }
}

// MARK: - Hashable

extension ArmPosition: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rightArmPositionType)
        hasher.combine(leftArmPositionType)
        hasher.combine(rightShoulderPositionType)
        hasher.combine(leftShoulderPositionType)
        hasher.combine(handDistanceType)
    }
}

// MARK: - CustomStringConvertible

extension ArmPosition: CustomStringConvertible {
    var description: String {
        "right arm: \(rightArmPositionType.rawValue), " +
        "right shoulder: \(rightShoulderPositionType.rawValue), " +
        "left shoulder: \(leftShoulderPositionType.rawValue), " +
        "left arm: \(leftArmPositionType.rawValue), " +
        "hands: \(handDistanceType.rawValue)"
    }
}
