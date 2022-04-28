//
//  BackgroundView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class BackgroundView: View {
    // MARK: Constants

    enum Constants {
        fileprivate static let durationMultiplier: CGFloat = 0.5
        fileprivate static let finishingDurationMultiplier: CGFloat = 1
    }

    // MARK: Properties

    private let gradientLayer = CAGradientLayer()
    private let firstCircle = RoundedView()
    private let secondCircle = RoundedView()
    private let rectangle = RoundedView()
    private let visualEffectView = EffectView()
    private var cancellables = Cancellables()
    var isAnimating = true {
        didSet {
            if isAnimating {
                setupAnimation()
            } else {
                CATransaction.begin()
                subviews.forEach { $0.layer.removeAllAnimations() }
                layer.removeAllAnimations()
                layoutIfNeeded()
                CATransaction.commit()
            }
        }
    }

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Overridden methods

extension BackgroundView {
    override var bounds: CGRect {
        didSet {
            gradientLayer.frame = bounds
            firstCircle.layer.cornerRadius = firstCircle.bounds.height / 2
        }
    }
}

// MARK: - Public methods

extension BackgroundView {
    func finish(completion: @escaping () -> Void) {
        finish(durationMultiplier: Constants.finishingDurationMultiplier, completion: completion)
    }
}

// MARK: - Setups

extension BackgroundView {
    private func setupView() {
        backgroundColor = Color.background.color
        clipsToBounds = true

        setupGradientLayer()
        setupFirstCircle()
        setupSecondCircle()
        setupRectangle()
        setupVisualEffect()
        setupAnimation()
        NotificationCenter.publisher(for: .name(UIApplication.willEnterForegroundNotification))
            .sink { [unowned self] _ in
                if isAnimating {
                    setupAnimation()
                }
            }
            .store(in: &cancellables)
    }

    private func setupGradientLayer() {
        gradientLayer.then {
            layer.addSublayer($0)
            $0.colors = [UIColor.cyan.withAlphaComponent(0.33).cgColor,
                         UIColor.purple.withAlphaComponent(0.11).cgColor]
            $0.startPoint = .zero
            $0.endPoint = .init(x: 1, y: 1)
            $0.locations = [0, 1]
        }
    }

    private func setupFirstCircle() {
        addSubview(firstCircle)

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        firstCircle.then {
            $0.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66).isActive = true
            $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66).isActive = true
            $0.backgroundColor = .blue.withAlphaComponent(0.3)
        }
    }

    private func setupSecondCircle() {
        addSubview(secondCircle)

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        secondCircle.then {
            $0.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
            $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
            $0.backgroundColor = .systemPink.withAlphaComponent(0.6)
        }
    }

    private func setupRectangle() {
        rectangle.multiplier = 0.25
        rectangle.transform = .init(rotationAngle: -.pi / 4)
        addSubview(rectangle)

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55).isActive = true
        layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        rectangle.then {
            $0.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65).isActive = true
            $0.backgroundColor = .systemMint.withAlphaComponent(0.4)
        }
    }

    private func setupVisualEffect() {
        visualEffectView.then {
            addSubview($0)
            $0.set(style: .systemUltraThinMaterial)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }

    private func setupAnimation() {
        firstCircle.transform = .identity
        secondCircle.transform = .identity
        rectangle.transform = .identity

        UIView.animate(withDuration: 15 * Constants.durationMultiplier,
                       delay: 1,
                       options: [.allowUserInteraction, .autoreverse, .curveEaseInOut, .repeat]) { [self] in
            firstCircle.transform = .init(scaleX: 1.5, y: 1.5)
                .concatenating(.init(translationX: 75, y: 125))
        }

        UIView.animate(withDuration: 20 * Constants.durationMultiplier,
                       delay: 0.75,
                       options: [.allowUserInteraction, .autoreverse, .curveEaseInOut, .repeat]) { [self] in
            secondCircle.transform = .init(scaleX: 0.25, y: 0.25)
                .concatenating(.init(translationX: -100, y: 150))
        }

        UIView.animate(withDuration: 25 * Constants.durationMultiplier,
                       delay: 0.25,
                       options: [.allowUserInteraction, .autoreverse, .curveEaseInOut, .repeat]) { [self] in
            rectangle.transform = rectangle.transform
                .concatenating(.init(scaleX: 0.75, y: 1.25))
                .concatenating(.init(translationX: -100, y: -150))
                .concatenating(.init(rotationAngle: 3 * .pi / 2))
        }
    }
}

extension BackgroundView {
    private func finish(durationMultiplier: TimeInterval, completion: @escaping () -> Void = { }) {
        UIView.animate(withDuration: 0.9 * durationMultiplier,
                       delay: .zero,
                       options: [.curveEaseOut, .allowUserInteraction]) { [self] in
            visualEffectView.effect = nil
            gradientLayer.opacity = .zero
        }
        UIView.animate(withDuration: 1 * durationMultiplier,
                       delay: 0.33,
                       options: [.curveEaseIn, .beginFromCurrentState, .allowUserInteraction],
                       animations: { [self] in
            firstCircle.transform = firstCircle.transform.concatenating(.init(translationX: 1000, y: 1000))
            secondCircle.transform = secondCircle.transform.concatenating(.init(translationX: 1000, y: -1000))
            rectangle.transform = rectangle.transform.concatenating(.init(translationX: -1000, y: -1000))
        }, completion: { _ in
            completion()
        })
    }
}
