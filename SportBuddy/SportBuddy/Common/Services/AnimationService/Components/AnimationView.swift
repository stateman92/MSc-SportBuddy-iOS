//
//  AnimationView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 10..
//

import Lottie

final class AnimationView: View {
    // MARK: Properties

    private let animationView: Lottie.AnimationView

    // MARK: Initialization

    init(jsonName: String) {
        animationView = .init(name: jsonName)
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension AnimationView {
    private func setupView() {
        setupLottie()
    }

    private func setupLottie() {
        animationView.then {
            $0.loopMode = .loop
            addSubview($0)
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - Public methods

extension AnimationView {
    /// Play the animation.
    func play() {
        animationView.play()
    }

    /// Pause the animation.
    func pause() {
        animationView.pause()
    }
}
