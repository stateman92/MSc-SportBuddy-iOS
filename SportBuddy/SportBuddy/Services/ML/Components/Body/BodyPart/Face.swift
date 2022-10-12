//
//  Face.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

struct Face {
    // swiftlint:disable identifier_name
    let nose_0: BoneEndpoint?
    let leftEyeInner_1: BoneEndpoint?
    let leftEye_2: BoneEndpoint?
    let leftEyeOuter_3: BoneEndpoint?
    let rightEyeInner_4: BoneEndpoint?
    let rightEye_5: BoneEndpoint?
    let rightEyeOuter_6: BoneEndpoint?
    let leftEar_7: BoneEndpoint?
    let rightEar_8: BoneEndpoint?
    let leftMouth_9: BoneEndpoint?
    let rightMouth_10: BoneEndpoint?
    // swiftlint:enable identifier_name
}

// MARK: - BodyPart

extension Face: BodyPart {
    var bones: [Bone] {
        [
            Bone(starting: nose_0, ending: leftEyeInner_1),
            Bone(starting: leftEyeInner_1, ending: leftEye_2),
            Bone(starting: leftEye_2, ending: leftEyeOuter_3),
            Bone(starting: leftEyeOuter_3, ending: leftEar_7),
            Bone(starting: nose_0, ending: rightEyeInner_4),
            Bone(starting: rightEyeInner_4, ending: rightEye_5),
            Bone(starting: rightEye_5, ending: rightEyeOuter_6),
            Bone(starting: rightEyeOuter_6, ending: rightEar_8),
            Bone(starting: rightMouth_10, ending: leftMouth_9)
        ]
    }
}

extension Face {
    static func - (lhs: Face, rhs: Face) -> Face {
        Face(nose_0: .difference(lhs: lhs.nose_0, rhs: rhs.nose_0),
             leftEyeInner_1: .difference(lhs: lhs.leftEyeInner_1, rhs: rhs.leftEyeInner_1),
             leftEye_2: .difference(lhs: lhs.leftEye_2, rhs: rhs.leftEye_2),
             leftEyeOuter_3: .difference(lhs: lhs.leftEyeOuter_3, rhs: rhs.leftEyeOuter_3),
             rightEyeInner_4: .difference(lhs: lhs.rightEyeInner_4, rhs: rhs.rightEyeInner_4),
             rightEye_5: .difference(lhs: lhs.rightEye_5, rhs: rhs.rightEye_5),
             rightEyeOuter_6: .difference(lhs: lhs.rightEyeOuter_6, rhs: rhs.rightEyeOuter_6),
             leftEar_7: .difference(lhs: lhs.leftEar_7, rhs: rhs.leftEar_7),
             rightEar_8: .difference(lhs: lhs.rightEar_8, rhs: rhs.rightEar_8),
             leftMouth_9: .difference(lhs: lhs.leftMouth_9, rhs: rhs.leftMouth_9),
             rightMouth_10: .difference(lhs: lhs.rightMouth_10, rhs: rhs.rightMouth_10))
    }

    static func / (lhs: Face, rhs: CGFloat) -> Face {
        Face(nose_0: lhs.nose_0 == nil ? nil : lhs.nose_0! / rhs,
             leftEyeInner_1: lhs.leftEyeInner_1 == nil ? nil : lhs.leftEyeInner_1! / rhs,
             leftEye_2: lhs.leftEye_2 == nil ? nil : lhs.leftEye_2! / rhs,
             leftEyeOuter_3: lhs.leftEyeOuter_3 == nil ? nil : lhs.leftEyeOuter_3! / rhs,
             rightEyeInner_4: lhs.rightEyeInner_4 == nil ? nil : lhs.rightEyeInner_4! / rhs,
             rightEye_5: lhs.rightEye_5 == nil ? nil : lhs.rightEye_5! / rhs,
             rightEyeOuter_6: lhs.rightEyeOuter_6 == nil ? nil : lhs.rightEyeOuter_6! / rhs,
             leftEar_7: lhs.leftEar_7 == nil ? nil : lhs.leftEar_7! / rhs,
             rightEar_8: lhs.rightEar_8 == nil ? nil : lhs.rightEar_8! / rhs,
             leftMouth_9: lhs.leftMouth_9 == nil ? nil : lhs.leftMouth_9! / rhs,
             rightMouth_10: lhs.rightMouth_10 == nil ? nil : lhs.rightMouth_10! / rhs)
    }
}
