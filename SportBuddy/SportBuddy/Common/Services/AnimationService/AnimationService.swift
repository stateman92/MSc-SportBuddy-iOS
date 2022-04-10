//
//  AnimationService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

/// A class for loading the images.
final class AnimationService {
    /// Initialize the service.
    init() { }
}

extension AnimationService: AnimationServiceProtocol {
    /// Load an image from an url.
    /// - Parameters:
    ///   - jsonName: the json name of the animation.
    ///   - view: the view.
    func load(jsonName: String, in view: View) {
        view.subviews.forEach { $0.removeFromSuperview() }
        AnimationView(jsonName: jsonName).then {
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
