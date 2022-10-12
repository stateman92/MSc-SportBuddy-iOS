//
//  Arms.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

struct Arms {
    // swiftlint:disable identifier_name
    let leftElbow_13: BoneEndpoint?
    let rightElbow_14: BoneEndpoint?
    let leftWrist_15: BoneEndpoint?
    let rightWrist_16: BoneEndpoint?
    let leftPinky_17: BoneEndpoint?
    let rightPinky_18: BoneEndpoint?
    let leftIndex_19: BoneEndpoint?
    let rightIndex_20: BoneEndpoint?
    let leftThumb_21: BoneEndpoint?
    let rightThumb_22: BoneEndpoint?
    // swiftlint:enable identifier_name
}

// MARK: - BodyPart

extension Arms: BodyPart {
    var bones: [Bone] {
        [
            Bone(starting: leftElbow_13, ending: leftWrist_15),
            Bone(starting: leftWrist_15, ending: leftThumb_21),
            Bone(starting: leftWrist_15, ending: leftIndex_19),
            Bone(starting: leftWrist_15, ending: leftPinky_17),
            Bone(starting: leftPinky_17, ending: leftIndex_19),

            Bone(starting: rightElbow_14, ending: rightWrist_16),
            Bone(starting: rightWrist_16, ending: rightThumb_22),
            Bone(starting: rightWrist_16, ending: rightIndex_20),
            Bone(starting: rightWrist_16, ending: rightPinky_18),
            Bone(starting: rightPinky_18, ending: rightIndex_20)
        ]
    }
}

extension Arms {
    static func - (lhs: Arms, rhs: Arms) -> Arms {
        Arms(leftElbow_13: .difference(lhs: lhs.leftElbow_13, rhs: rhs.leftElbow_13),
             rightElbow_14: .difference(lhs: lhs.rightElbow_14, rhs: rhs.rightElbow_14),
             leftWrist_15: .difference(lhs: lhs.leftWrist_15, rhs: rhs.leftWrist_15),
             rightWrist_16: .difference(lhs: lhs.rightWrist_16, rhs: rhs.rightWrist_16),
             leftPinky_17: .difference(lhs: lhs.leftPinky_17, rhs: rhs.leftPinky_17),
             rightPinky_18: .difference(lhs: lhs.rightPinky_18, rhs: rhs.rightPinky_18),
             leftIndex_19: .difference(lhs: lhs.leftIndex_19, rhs: rhs.leftIndex_19),
             rightIndex_20: .difference(lhs: lhs.rightIndex_20, rhs: rhs.rightIndex_20),
             leftThumb_21: .difference(lhs: lhs.leftThumb_21, rhs: rhs.leftThumb_21),
             rightThumb_22: .difference(lhs: lhs.rightThumb_22, rhs: rhs.rightThumb_22))
    }

    static func / (lhs: Arms, rhs: CGFloat) -> Arms {
        Arms(leftElbow_13: lhs.leftElbow_13 == nil ? nil : lhs.leftElbow_13! / rhs,
             rightElbow_14: lhs.rightElbow_14 == nil ? nil : lhs.rightElbow_14! / rhs,
             leftWrist_15: lhs.leftWrist_15 == nil ? nil : lhs.leftWrist_15! / rhs,
             rightWrist_16: lhs.rightWrist_16 == nil ? nil : lhs.rightWrist_16! / rhs,
             leftPinky_17: lhs.leftPinky_17 == nil ? nil : lhs.leftPinky_17! / rhs,
             rightPinky_18: lhs.rightPinky_18 == nil ? nil : lhs.rightPinky_18! / rhs,
             leftIndex_19: lhs.leftIndex_19 == nil ? nil : lhs.leftIndex_19! / rhs,
             rightIndex_20: lhs.rightIndex_20 == nil ? nil : lhs.rightIndex_20! / rhs,
             leftThumb_21: lhs.leftThumb_21 == nil ? nil : lhs.leftThumb_21! / rhs,
             rightThumb_22: lhs.rightThumb_22 == nil ? nil : lhs.rightThumb_22! / rhs)
    }
}
