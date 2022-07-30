//
//  AnimationService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

import Foundation

/// A protocol for loading the animations.
protocol AnimationService: Initable, AutoMockable {
    /// Load an image from an url.
    /// - Parameters:
    ///   - animation: the animation.
    ///   - view: the view.
    func load(animation: Animations, in view: View)

    /// Play the animation.
    /// - Parameter view: the view.
    func play(in view: View)

    /// Pause the animation.
    /// - Parameter view: the view.
    func pause(in view: View)
}
