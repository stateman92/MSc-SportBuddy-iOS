//
//  AnimationCurve+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

extension UIView.AnimationCurve {
    /// Get the timing function as `UIView.AnimationOptions`.
    /// - Note:
    /// If `self` cannot represented with one of the `class` variables, then the returned options will be empty.
    public var asAnimationOptions: UIView.AnimationOptions {
        switch self {
        case .easeIn: return .curveEaseIn
        case .easeOut: return .curveEaseOut
        case .easeInOut: return .curveEaseInOut
        case .linear: return .curveLinear
        default: return []
        }
    }
}
