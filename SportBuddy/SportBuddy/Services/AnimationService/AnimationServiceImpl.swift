//
//  AnimationServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

/// A class for loading the images.
final class AnimationServiceImpl {
    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - AnimationService

extension AnimationServiceImpl: AnimationService {
    /// Load an image from an url.
    /// - Parameters:
    ///   - animation: the animation.
    ///   - view: the view.
    func load(animation: Animations, in view: View) {
        view.subviews.forEach { $0.removeFromSuperview() }
        AnimationView(animation: animation).then {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }

    /// Play the animation.
    /// - Parameter view: the view.
    func play(in view: View) {
        view.subviews.compactMap { $0 as? AnimationView }.forEach { $0.play() }
    }

    /// Pause the animation.
    /// - Parameter view: the view.
    func pause(in view: View) {
        view.subviews.compactMap { $0 as? AnimationView }.forEach { $0.pause() }
    }
}
