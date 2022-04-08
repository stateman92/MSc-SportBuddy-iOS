//
//  CAMediaTimingFunction+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

extension CAMediaTimingFunction {
    /// The default `CAMediaTimingFunction`.
    public class var `default`: Self {
        Self(name: .default)
    }

    /// The ease in (begins slowly) `CAMediaTimingFunction`.
    public class var easeIn: Self {
        Self(name: .easeIn)
    }

    /// The ease out (finishes slowly) `CAMediaTimingFunction`.
    public class var easeOut: Self {
        Self(name: .easeOut)
    }

    /// The linear `CAMediaTimingFunction`.
    public class var linear: Self {
        Self(name: .linear)
    }

    /// The ease in ease out (begins and finishes slowly) `CAMediaTimingFunction`.
    public class var easeInEaseOut: Self {
        Self(name: .easeInEaseOut)
    }

    /// Initialize a timing function modeled as a cubic Bezier curve using the specified control points.
    /// - Parameters:
    ///   - controlPoint1: the first control point.
    ///   - controlPoint2: the second control point.
    public convenience init(controlPoint1: CGPoint, controlPoint2: CGPoint) {
        self.init(controlPoints: controlPoint1.x.float,
                  controlPoint1.y.float,
                  controlPoint2.x.float,
                  controlPoint2.y.float)
    }

    /// Get the timing function as `UIView.AnimationOptions`.
    /// - Note:
    /// If `self` cannot represented with one of the `class` variables, then the returned options will be empty.
    public var asAnimationOptions: UIView.AnimationOptions {
        switch self {
        case .easeIn: return .curveEaseIn
        case .easeOut: return .curveEaseOut
        case .linear, .default: return .curveLinear
        case .easeInEaseOut: return .curveEaseInOut
        default: return []
        }
    }

    /// Initialize a timing function from a `UIView.AnimationOptions`.
    /// - Parameters:
    ///   - from: the options.
    /// - Note:
    /// If the `UIView.AnimationOptions` doesn't contain a timing function, then `self` will be `.linear`.
    public convenience init(from options: UIView.AnimationOptions) {
        if options.contains(.curveEaseIn) {
            self.init(name: .easeIn)
        } else if options.contains(.curveEaseOut) {
            self.init(name: .easeOut)
        } else if options.contains(.curveEaseInOut) {
            self.init(name: .easeInEaseOut)
        } else {
            self.init(name: .linear)
        }
    }
}
