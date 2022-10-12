//
//  Legs.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

struct Legs {
    // swiftlint:disable identifier_name
    let leftKnee_25: BoneEndpoint?
    let rightKnee_26: BoneEndpoint?
    let leftAnkle_27: BoneEndpoint?
    let rightAnkle_28: BoneEndpoint?
    let leftHeel_29: BoneEndpoint?
    let rightHeel_30: BoneEndpoint?
    let leftFootIndex_31: BoneEndpoint?
    let rightFootIndex_32: BoneEndpoint?
    // swiftlint:enable identifier_name
}

// MARK: - BodyPart

extension Legs: BodyPart {
    var bones: [Bone] {
        [
            Bone(starting: leftKnee_25, ending: leftAnkle_27),
            Bone(starting: leftAnkle_27, ending: leftHeel_29),
            Bone(starting: leftAnkle_27, ending: leftFootIndex_31),
            Bone(starting: leftHeel_29, ending: leftFootIndex_31),

            Bone(starting: rightKnee_26, ending: rightAnkle_28),
            Bone(starting: rightAnkle_28, ending: rightHeel_30),
            Bone(starting: rightAnkle_28, ending: rightFootIndex_32),
            Bone(starting: rightHeel_30, ending: rightFootIndex_32)
        ]
    }
}

extension Legs {
    static func - (lhs: Legs, rhs: Legs) -> Legs {
        Legs(leftKnee_25: .difference(lhs: lhs.leftKnee_25, rhs: rhs.leftKnee_25),
             rightKnee_26: .difference(lhs: lhs.rightKnee_26, rhs: rhs.rightKnee_26),
             leftAnkle_27: .difference(lhs: lhs.leftAnkle_27, rhs: rhs.leftAnkle_27),
             rightAnkle_28: .difference(lhs: lhs.rightAnkle_28, rhs: rhs.rightAnkle_28),
             leftHeel_29: .difference(lhs: lhs.leftHeel_29, rhs: rhs.leftHeel_29),
             rightHeel_30: .difference(lhs: lhs.rightHeel_30, rhs: rhs.rightHeel_30),
             leftFootIndex_31: .difference(lhs: lhs.leftFootIndex_31, rhs: rhs.leftFootIndex_31),
             rightFootIndex_32: .difference(lhs: lhs.rightFootIndex_32, rhs: rhs.rightFootIndex_32))
    }

    static func / (lhs: Legs, rhs: CGFloat) -> Legs {
        Legs(leftKnee_25: lhs.leftKnee_25 == nil ? nil : lhs.leftKnee_25! / rhs,
             rightKnee_26: lhs.rightKnee_26 == nil ? nil : lhs.rightKnee_26! / rhs,
             leftAnkle_27: lhs.leftAnkle_27 == nil ? nil : lhs.leftAnkle_27! / rhs,
             rightAnkle_28: lhs.rightAnkle_28 == nil ? nil : lhs.rightAnkle_28! / rhs,
             leftHeel_29: lhs.leftHeel_29 == nil ? nil : lhs.leftHeel_29! / rhs,
             rightHeel_30: lhs.rightHeel_30 == nil ? nil : lhs.rightHeel_30! / rhs,
             leftFootIndex_31: lhs.leftFootIndex_31 == nil ? nil : lhs.leftFootIndex_31! / rhs,
             rightFootIndex_32: lhs.rightFootIndex_32 == nil ? nil : lhs.rightFootIndex_32! / rhs)
    }
}
