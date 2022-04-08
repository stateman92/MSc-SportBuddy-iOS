//
//  BinaryFloatingPoint+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

extension BinaryFloatingPoint {
    /// The absolute value of the value.
    var abs: Self {
        Swift.abs(self)
    }

    /// The ceil of the value.
    var ceil: Self {
        Foundation.ceil(self)
    }

    /// The floor of the value.
    var floor: Self {
        Foundation.floor(self)
    }

    /// Whether the value is positive.
    var isPositive: Bool {
        self > .zero
    }

    /// Whether the value is negative.
    var isNegative: Bool {
        self < .zero
    }

    /// The rounded value of the value.
    var round: Self {
        Foundation.round(self)
    }

    /// The root of the value.
    var sqrt: Self {
        Foundation.sqrt(self)
    }

    /// The truncated value of the value.
    var trunc: Self {
        Foundation.trunc(self)
    }
}

extension BinaryFloatingPoint {
    /// Convert the `BinaryFloatingPoint` to a `CGFloat`.
    var cgFloat: CGFloat {
        CGFloat(self)
    }

    /// Convert the `BinaryFloatingPoint` to an `Int`.
    var int: Int {
        Int(self)
    }

    /// Convert the `BinaryFloatingPoint` to a `Double`.
    var double: Double {
        Double(self)
    }

    /// Convert the `BinaryFloatingPoint` to a `Float`.
    var float: Float {
        Float(self)
    }
}
