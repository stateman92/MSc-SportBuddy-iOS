//
//  PathComponent.swift
//  GoogleMLKitPoseDetection
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import UIKit

struct PathComponent {
    /// The color of the border.
    let strokeColor: UIColor

    /// The color of the inner content.
    let fillColor: UIColor

    /// The width of the line (in points).
    let lineWidth: CGFloat

    /// Create a `PathComponent`.
    /// - Parameters:
    ///   - strokeColor: the color of the border. By default `.systemRed`.
    ///   - fillColor: the color of the inner content. By default `.yellow`.
    ///   - lineWidth: the width of the line (in points). By default `4`.
    init(strokeColor: UIColor = .systemRed, fillColor: UIColor = .yellow, lineWidth: CGFloat = 4) {
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        self.lineWidth = lineWidth
    }
}
