//
//  Body.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

struct Body {
    // swiftlint:disable identifier_name
    let leftShoulder_11: BoneEndpoint?
    let rightShoulder_12: BoneEndpoint?
    let leftHip_23: BoneEndpoint?
    let rightHip_24: BoneEndpoint?
    // swiftlint:enable identifier_name
}

// MARK: - BodyPart

extension Body: BodyPart {
    var bones: [Bone] {
        [
            Bone(starting: rightShoulder_12, ending: rightHip_24),
            Bone(starting: rightHip_24, ending: leftHip_23),
            Bone(starting: leftHip_23, ending: leftShoulder_11),
            Bone(starting: leftShoulder_11, ending: rightShoulder_12)
        ]
    }
}

extension Body {
    static func - (lhs: Body, rhs: Body) -> Body {
        Body(leftShoulder_11: .difference(lhs: lhs.leftShoulder_11, rhs: rhs.leftShoulder_11),
             rightShoulder_12: .difference(lhs: lhs.rightShoulder_12, rhs: rhs.rightShoulder_12),
             leftHip_23: .difference(lhs: lhs.leftHip_23, rhs: rhs.leftHip_23),
             rightHip_24: .difference(lhs: lhs.rightHip_24, rhs: rhs.rightHip_24))
    }

    static func / (lhs: Body, rhs: CGFloat) -> Body {
        Body(leftShoulder_11: lhs.leftShoulder_11 == nil ? nil : lhs.leftShoulder_11! / rhs,
             rightShoulder_12: lhs.rightShoulder_12 == nil ? nil : lhs.rightShoulder_12! / rhs,
             leftHip_23: lhs.leftHip_23 == nil ? nil : lhs.leftHip_23! / rhs,
             rightHip_24: lhs.rightHip_24 == nil ? nil : lhs.rightHip_24! / rhs)
    }
}
