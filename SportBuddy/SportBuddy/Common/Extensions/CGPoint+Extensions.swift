//
//  CGPoint+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import CoreGraphics

extension CGPoint {
    /// Calculate the distance between two `CGPoint`s.
    /// - Parameters:
    ///   - from: the other `CGPoint`.
    /// - Returns:
    ///     The distance.
    func distance(from other: Self) -> CGFloat {
        sqrt(pow((x - other.x), 2) + pow((y - other.y), 2))
    }

    /// Calculate the middle point between two `CGPoint`s.
    /// - Parameters:
    ///   - _: the other `CGPoint`.
    /// - Returns:
    ///     The middle point.
    public func midBetween(_ other: CGPoint) -> CGPoint {
        CGPoint(x: (x + other.x) / 2, y: (y + other.y) / 2)
    }
}

extension CGPoint {
    /// Add the `rhs` parameter to the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    /// - Returns:
    ///     The result.
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Add the `rhs` parameter to the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    /// Subtract the `rhs` parameter from the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    /// - Returns:
    ///     The result.
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Subtract the `rhs` parameter from the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    /// Multiply the `rhs` parameter with the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    /// - Returns:
    ///     The result.
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Multiply the `rhs` parameter with the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    /// - Returns:
    ///     The result.
    static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        CGPoint(x: rhs.x * lhs, y: rhs.y * lhs)
    }

    /// Multiply the `rhs` parameter with the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    static func *= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs.x *= rhs
        lhs.y *= rhs
    }

    /// Divide the `rhs` parameter with the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    /// - Returns:
    ///     The result.
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    /// Divide the `rhs` parameter with the `lhs` parameter.
    /// - Parameters:
    ///   - lhs: the lhs parameter.
    ///   - rhs: the rhs parameter.
    static func /= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs.x /= rhs
        lhs.y /= rhs
    }
}
