//
//  UIBezierPath+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 13..
//

import UIKit

extension UIBezierPath {
    /// Create a circular `UIBezierPath`.
    /// - Parameters:
    ///   - center: the center of the circle.
    ///   - radius: the radius of the circle.
    class func circle(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        UIBezierPath(ovalIn: .init(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius))
    }

    /// Create a line.
    /// - Parameters:
    ///   - _: the line.
    /// - Returns:
    ///     The line as a bezier path.
    class func line(_ line: CGLine) -> Self {
        let path = Self()
        path.move(to: line.startingPoint)
        path.addLine(to: line.endingPoint)
        path.close()
        return path
    }

    /// Draw the context with the given `PathComponent`.
    /// - Parameters:
    ///   - pathComponent: the `PathComponent`.
    /// - Returns:
    ///     The bezier path.
    @discardableResult func drawWith(pathComponent: PathComponent) -> Self {
        close()
        pathComponent.strokeColor.setStroke()
        pathComponent.fillColor.setFill()
        lineWidth = pathComponent.lineWidth
        stroke()
        fill()
        return self
    }
}
