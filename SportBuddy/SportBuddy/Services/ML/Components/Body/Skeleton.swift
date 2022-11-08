//
//  Skeleton.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics
import SwiftUI

struct Skeleton {
    let face: Face
    let body: Body
    let arms: Arms
    let legs: Legs

    struct Builder {
        var boneEndpoints: [BoneEndpoint]
    }
}

extension Skeleton {
    static var empty: Skeleton {
        .init()
    }

    init(from boneEndpoints: [BoneEndpoint] = .init()) {
        self = Builder(boneEndpoints: boneEndpoints).skeleton
    }
}

// MARK: - BodyPart

extension Skeleton: BodyPart {
    var bones: [Bone] {
        face.bones + body.bones + arms.bones + legs.bones + connectingBones
    }

    private var boneEndpoints: [BoneEndpoint] {
        bones.map { [$0.starting, $0.ending] }.flatMap { $0 }.compactMap { $0 }.uniqueArray
    }
}

extension Skeleton {
    var referenceDistance: CGFloat {
        let shoulder = {
            let rightShoulder = boneEndpoints.first(where: { $0.type == .rightShoulder })
            let leftShoulder = boneEndpoints.first(where: { $0.type == .leftShoulder })
            if let rightShoulder, let leftShoulder {
                return rightShoulder.coordinate.midBetween(leftShoulder.coordinate)
            }
            return rightShoulder?.coordinate ?? leftShoulder?.coordinate ?? .zero
        }()
        let hip = {
            let rightHip = boneEndpoints.first(where: { $0.type == .rightHip })
            let leftHip = boneEndpoints.first(where: { $0.type == .leftHip })
            if let rightHip, let leftHip {
                return rightHip.coordinate.midBetween(leftHip.coordinate)
            }
            return rightHip?.coordinate ?? leftHip?.coordinate ?? .zero
        }()
        let distance = shoulder.distance(from: hip)
        return distance > .zero ? distance : .ulpOfOne
    }

    func armPosition(referenceDistance: CGFloat? = nil) -> ArmPosition? {
        let referenceDistance = referenceDistance ?? self.referenceDistance
        guard let rightWrist = boneEndpoints.first(where: { $0.type == .rightWrist }),
              let rightElbow = boneEndpoints.first(where: { $0.type == .rightElbow }),
              let rightShoulder = boneEndpoints.first(where: { $0.type == .rightShoulder }),
              let leftShoulder = boneEndpoints.first(where: { $0.type == .leftShoulder }),
              let leftElbow = boneEndpoints.first(where: { $0.type == .leftElbow }),
              let leftWrist = boneEndpoints.first(where: { $0.type == .leftWrist })
        else {
            return nil
        }
        let direction = rightWrist.coordinate.x > leftWrist.coordinate.x ? -1.cgFloat : 1.cgFloat
        return ArmPosition(
            rightForeArm: rightWrist.coordinate.distance(from: rightElbow.coordinate) / referenceDistance,
            rightArmAngle: getAngleBetween(firstBoneEndpoint: rightWrist,
                                           middleBoneEndpoint: rightElbow,
                                           thirdBoneEndpoint: rightShoulder),
            rightUpperArm: rightElbow.coordinate.distance(from: rightShoulder.coordinate) / referenceDistance,
            rightShoulderAngle: getAngleBetween(firstBoneEndpoint: rightElbow,
                                                middleBoneEndpoint: rightShoulder,
                                                thirdBoneEndpoint: leftShoulder),
            leftShoulderAngle: getAngleBetween(firstBoneEndpoint: rightShoulder,
                                               middleBoneEndpoint: leftShoulder,
                                               thirdBoneEndpoint: leftElbow),
            leftForeArm: leftElbow.coordinate.distance(from: leftWrist.coordinate) / referenceDistance,
            leftArmAngle: getAngleBetween(firstBoneEndpoint: leftShoulder,
                                          middleBoneEndpoint: leftElbow,
                                          thirdBoneEndpoint: leftWrist),
            leftUpperArm: leftShoulder.coordinate.distance(from: leftElbow.coordinate) / referenceDistance,
            handsDistance: rightWrist.coordinate.distance(from: leftWrist.coordinate) / referenceDistance * direction
        )
    }

    func legPosition(referenceDistance: CGFloat? = nil) -> LegPosition? {
        let referenceDistance = referenceDistance ?? self.referenceDistance
        guard let rightAnkle = boneEndpoints.first(where: { $0.type == .rightAnkle }),
              let rightKnee = boneEndpoints.first(where: { $0.type == .rightKnee }),
              let rightHip = boneEndpoints.first(where: { $0.type == .rightHip }),
              let leftHip = boneEndpoints.first(where: { $0.type == .leftHip }),
              let leftKnee = boneEndpoints.first(where: { $0.type == .leftKnee }),
              let leftAnkle = boneEndpoints.first(where: { $0.type == .leftAnkle })
        else {
            return nil
        }
        let direction = rightAnkle.coordinate.x > leftAnkle.coordinate.x ? -1.cgFloat : 1.cgFloat
        return LegPosition(
            rightCalf: rightAnkle.coordinate.distance(from: rightKnee.coordinate) / referenceDistance,
            rightLegAngle: getAngleBetween(firstBoneEndpoint: rightAnkle,
                                           middleBoneEndpoint: rightKnee,
                                           thirdBoneEndpoint: rightHip),
            rightThigh: rightKnee.coordinate.distance(from: rightHip.coordinate) / referenceDistance,
            rightHipAngle: getAngleBetween(firstBoneEndpoint: rightKnee,
                                           middleBoneEndpoint: rightHip,
                                           thirdBoneEndpoint: leftHip),
            leftHipAngle: getAngleBetween(firstBoneEndpoint: rightHip,
                                          middleBoneEndpoint: leftHip,
                                          thirdBoneEndpoint: leftKnee),
            leftThigh: leftHip.coordinate.distance(from: leftKnee.coordinate) / referenceDistance,
            leftLegAngle: getAngleBetween(firstBoneEndpoint: leftHip,
                                          middleBoneEndpoint: leftKnee,
                                          thirdBoneEndpoint: leftAnkle),
            leftCalf: leftKnee.coordinate.distance(from: leftAnkle.coordinate) / referenceDistance,
            feetDistance: rightAnkle.coordinate.distance(from: leftAnkle.coordinate) / referenceDistance * direction
        )
    }

    func staticCharacteristics(referenceDistance: CGFloat? = nil) -> StaticCharacteristics {
        let armPosition = armPosition(referenceDistance: referenceDistance)
        let legPosition = legPosition(referenceDistance: referenceDistance)
        return StaticCharacteristics(
            handsDistance: armPosition?.handDistanceType ?? .around0,
            legsDistance: legPosition?.feetDistanceType ?? .around0,
            leftFeetHipDistance: legPosition?.leftFeetHipDistance ?? .around0,
            rightFeetHipDistance: legPosition?.rightFeetHipDistance ?? .around0,
            leftHandShoulderDistance: armPosition?.leftHandShoulderDistance ?? .around0,
            rightHandShoulderDistance: armPosition?.rightHandShoulderDistance ?? .around0,
            rightHipAngle: .init(degrees: (legPosition?.rightHipAngle ?? .radians(.zero)).degrees),
            leftHipAngle: .init(degrees: (legPosition?.leftHipAngle ?? .radians(.zero)).degrees),
            rightShoulderAngle: .init(degrees: (armPosition?.rightShoulderAngle ?? .radians(.zero)).degrees),
            leftShoulderAngle: .init(degrees: (armPosition?.leftShoulderAngle ?? .radians(.zero)).degrees)
        )
    }

    func dynamicCharacteristics(referenceDistance: CGFloat? = nil) -> DynamicCharacteristics {
        let leftHip = boneEndpoints.first { $0.type == .leftHip }?.coordinate ?? .zero
        let rightHip = boneEndpoints.first { $0.type == .rightHip }?.coordinate ?? .zero
        let leftShoulder = boneEndpoints.first { $0.type == .leftShoulder }?.coordinate ?? .zero
        let rightShoulder = boneEndpoints.first { $0.type == .rightShoulder }?.coordinate ?? .zero
        let leftHand = boneEndpoints.first { $0.type == .leftWrist }?.coordinate ?? .zero
        let rightHand = boneEndpoints.first { $0.type == .rightWrist }?.coordinate ?? .zero
        let leftAnkle = boneEndpoints.first { $0.type == .leftAnkle }?.coordinate ?? .zero
        let rightAnkle = boneEndpoints.first { $0.type == .rightAnkle }?.coordinate ?? .zero

        let referenceDistance = referenceDistance ?? self.referenceDistance
        let hipMovementDistanceX = DistanceType(distance: (leftHip.x + rightHip.x) / (2 * referenceDistance))
        let hipMovementDistanceY = DistanceType(distance: (leftHip.y + rightHip.y) / (2 * referenceDistance))
        let shoulderMovementDistanceX = DistanceType(distance: (leftShoulder.x + rightShoulder.x) /
                                                     (2 * referenceDistance))
        let shoulderMovementDistanceY = DistanceType(distance: (leftShoulder.y + rightShoulder.y) /
                                                     (2 * referenceDistance))
        let leftHandMovementDistanceX = DistanceType(distance: leftHand.x / referenceDistance)
        let rightHandMovementDistanceX = DistanceType(distance: rightHand.x / referenceDistance)
        let leftHandMovementDistanceY = DistanceType(distance: leftHand.y / referenceDistance)
        let rightHandMovementDistanceY = DistanceType(distance: rightHand.y / referenceDistance)
        let leftFeetMovementDistanceX = DistanceType(distance: leftAnkle.x / referenceDistance)
        let rightFeetMovementDistanceX = DistanceType(distance: rightAnkle.x / referenceDistance)
        let leftFeetMovementDistanceY = DistanceType(distance: leftAnkle.y / referenceDistance)
        let rightFeetMovementDistanceY = DistanceType(distance: rightAnkle.y / referenceDistance)

        return DynamicCharacteristics(hipMovementDistanceX: hipMovementDistanceX,
                                      hipMovementDistanceY: hipMovementDistanceY,
                                      shoulderMovementDistanceX: shoulderMovementDistanceX,
                                      shoulderMovementDistanceY: shoulderMovementDistanceY,
                                      leftHandMovementDistanceX: leftHandMovementDistanceX,
                                      leftHandMovementDistanceY: leftHandMovementDistanceY,
                                      rightHandMovementDistanceX: rightHandMovementDistanceX,
                                      rightHandMovementDistanceY: rightHandMovementDistanceY,
                                      leftFeetMovementDistanceX: leftFeetMovementDistanceX,
                                      leftFeetMovementDistanceY: leftFeetMovementDistanceY,
                                      rightFeetMovementDistanceX: rightFeetMovementDistanceX,
                                      rightFeetMovementDistanceY: rightFeetMovementDistanceY)
    }
}

extension Skeleton {
    private var connectingBones: [Bone] {
        [
            Bone(starting: body.leftShoulder_11, ending: arms.leftElbow_13),
            Bone(starting: body.rightShoulder_12, ending: arms.rightElbow_14),
            Bone(starting: body.leftHip_23, ending: legs.leftKnee_25),
            Bone(starting: body.rightHip_24, ending: legs.rightKnee_26)
        ]
    }

    private func getAngleBetween(firstBoneEndpoint: BoneEndpoint,
                                 middleBoneEndpoint: BoneEndpoint,
                                 thirdBoneEndpoint: BoneEndpoint) -> Angle {
        let radians: CGFloat =
        atan2(thirdBoneEndpoint.coordinate.y - middleBoneEndpoint.coordinate.y,
              thirdBoneEndpoint.coordinate.x - middleBoneEndpoint.coordinate.x) -
        atan2(firstBoneEndpoint.coordinate.y - middleBoneEndpoint.coordinate.y,
              firstBoneEndpoint.coordinate.x - middleBoneEndpoint.coordinate.x)
        var degrees = radians * 180.0 / .pi
        degrees = abs(degrees)
        if degrees > 180.0 {
            degrees = 360.0 - degrees
        }
        return .degrees(degrees)
    }
}

extension Skeleton.Builder {
    var skeleton: Skeleton {
        Skeleton(face: face, body: body, arms: arms, legs: legs)
    }

    private var face: Face {
        Face(
            nose_0: boneEndpoints.first { $0.type == .nose },
            leftEyeInner_1: boneEndpoints.first { $0.type == .leftEyeInner },
            leftEye_2: boneEndpoints.first { $0.type == .leftEye },
            leftEyeOuter_3: boneEndpoints.first { $0.type == .leftEyeOuter },
            rightEyeInner_4: boneEndpoints.first { $0.type == .rightEyeInner },
            rightEye_5: boneEndpoints.first { $0.type == .rightEye },
            rightEyeOuter_6: boneEndpoints.first { $0.type == .rightEyeOuter },
            leftEar_7: boneEndpoints.first { $0.type == .leftEar },
            rightEar_8: boneEndpoints.first { $0.type == .rightEar },
            leftMouth_9: boneEndpoints.first { $0.type == .mouthLeft },
            rightMouth_10: boneEndpoints.first { $0.type == .mouthRight }
        )
    }

    private var body: Body {
        Body(
            leftShoulder_11: boneEndpoints.first { $0.type == .leftShoulder },
            rightShoulder_12: boneEndpoints.first { $0.type == .rightShoulder },
            leftHip_23: boneEndpoints.first { $0.type == .leftHip },
            rightHip_24: boneEndpoints.first { $0.type == .rightHip }
        )
    }

    private var arms: Arms {
        Arms(
            leftElbow_13: boneEndpoints.first { $0.type == .leftElbow },
            rightElbow_14: boneEndpoints.first { $0.type == .rightElbow },
            leftWrist_15: boneEndpoints.first { $0.type == .leftWrist },
            rightWrist_16: boneEndpoints.first { $0.type == .rightWrist },
            leftPinky_17: boneEndpoints.first { $0.type == .leftPinkyFinger },
            rightPinky_18: boneEndpoints.first { $0.type == .rightPinkyFinger },
            leftIndex_19: boneEndpoints.first { $0.type == .leftIndexFinger },
            rightIndex_20: boneEndpoints.first { $0.type == .rightIndexFinger },
            leftThumb_21: boneEndpoints.first { $0.type == .leftThumb },
            rightThumb_22: boneEndpoints.first { $0.type == .rightThumb }
        )
    }

    private var legs: Legs {
        Legs(
            leftKnee_25: boneEndpoints.first { $0.type == .leftKnee },
            rightKnee_26: boneEndpoints.first { $0.type == .rightKnee },
            leftAnkle_27: boneEndpoints.first { $0.type == .leftAnkle },
            rightAnkle_28: boneEndpoints.first { $0.type == .rightAnkle },
            leftHeel_29: boneEndpoints.first { $0.type == .leftHeel },
            rightHeel_30: boneEndpoints.first { $0.type == .rightHeel },
            leftFootIndex_31: boneEndpoints.first { $0.type == .leftToe },
            rightFootIndex_32: boneEndpoints.first { $0.type == .rightToe }
        )
    }
}

// MARK: - CustomStringConvertible

extension Skeleton: CustomStringConvertible {
    var description: String {
        let armPosition = armPosition()
        let legPosition = legPosition()
        return """
            Arms: right forearm and upperarm angle:     \(armPosition?.rightArmAngle.degrees ?? .nan) degrees,
                  right upperarm and shoulder angle:    \(armPosition?.rightShoulderAngle.degrees ?? .nan) degrees,
                  left shoulder and upperarm angle:     \(armPosition?.leftShoulderAngle.degrees ?? .nan) degrees,
                  left upperarm and forearm angle:      \(armPosition?.leftArmAngle.degrees ?? .nan) degrees,
                  distance between the two hands:       \(armPosition?.handsDistance ?? .nan) * hip-shoulder distance.
            Leg: right calf and thigh angle:            \(legPosition?.rightLegAngle.degrees ?? .nan) degrees,
                 right thigh and hip angle:             \(legPosition?.rightHipAngle.degrees ?? .nan) degrees,
                 left hip and thigh angle:              \(legPosition?.leftHipAngle.degrees ?? .nan) degrees,
                 left thigh and calf angle:             \(legPosition?.leftLegAngle.degrees ?? .nan) degrees,
                 distance between the two feet:         \(legPosition?.feetDistance ?? .nan) * hip-shoulder distance.
            """
    }

    func derivativeCoordinateDescription(referenceDistance: CGFloat?) -> String {
        let dynamicCharacteristics = dynamicCharacteristics(referenceDistance: referenceDistance)
        return "Data: leftHandMovementDistanceX: \(dynamicCharacteristics.leftHandMovementDistanceX.rawValue), " +
        "leftHandMovementDistanceY: \(dynamicCharacteristics.leftHandMovementDistanceY.rawValue), " +
        "rightHandMovementDistanceX: \(dynamicCharacteristics.rightHandMovementDistanceX.rawValue), " +
        "rightHandMovementDistanceY: \(dynamicCharacteristics.rightHandMovementDistanceY.rawValue), " +
        "leftFeetMovementDistanceX: \(dynamicCharacteristics.leftFeetMovementDistanceX.rawValue), " +
        "leftFeetMovementDistanceY: \(dynamicCharacteristics.leftFeetMovementDistanceY.rawValue), " +
        "rightFeetMovementDistanceX: \(dynamicCharacteristics.rightFeetMovementDistanceX.rawValue), " +
        "rightFeetMovementDistanceY: \(dynamicCharacteristics.rightFeetMovementDistanceY.rawValue), " +
        "hipMovementDistanceX: \(dynamicCharacteristics.hipMovementDistanceX.rawValue), " +
        "hipMovementDistanceY: \(dynamicCharacteristics.hipMovementDistanceY.rawValue), " +
        "shoulderMovementDistanceX: \(dynamicCharacteristics.shoulderMovementDistanceX.rawValue), " +
        "shoulderMovementDistanceY: \(dynamicCharacteristics.shoulderMovementDistanceY.rawValue)"
    }

    var coordinateDescription: String {
        let staticCharacteristics = staticCharacteristics()
        return "Data: handsDistance: \(staticCharacteristics.handsDistance.rawValue), " +
        "legsDistance: \(staticCharacteristics.legsDistance.rawValue), " +
        "leftFeetHipDistance: \(staticCharacteristics.leftFeetHipDistance.rawValue), " +
        "rightFeetHipDistance: \(staticCharacteristics.rightFeetHipDistance.rawValue), " +
        "leftHandShoulderDistance: \(staticCharacteristics.leftHandShoulderDistance.rawValue)," +
        "rightHandShoulderDistance: \(staticCharacteristics.rightHandShoulderDistance.rawValue), " +
        "leftShoulderAngle: \(staticCharacteristics.leftShoulderAngle.rawValue), " +
        "rightShoulderAngle: \(staticCharacteristics.rightShoulderAngle.rawValue), " +
        "leftHipAngle: \(staticCharacteristics.leftHipAngle.rawValue), " +
        "rightHipAngle: \(staticCharacteristics.rightHipAngle.rawValue)"
    }
}
