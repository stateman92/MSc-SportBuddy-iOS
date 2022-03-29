//
//  BackgroundView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class BackgroundView: View {
    enum Constants {
        fileprivate static let durationMultiplier: CGFloat = 1
    }

    private let gradientLayer = CAGradientLayer()
    private let firstCircle = RoundedView()
    private let secondCircle = RoundedView()
    private let rectangle = RoundedView()
    private let firstVisualEffect = VisualEffectView()
    private let secondVisualEffect = VisualEffectView()

    override var bounds: CGRect {
        didSet {
            gradientLayer.frame = bounds
            firstCircle.layer.cornerRadius = firstCircle.bounds.height / 2
        }
    }

    override init() {
        super.init()
        setupView()
    }
}

extension BackgroundView {
    private func setupView() {
        backgroundColor = Color.background.color
        setupGradientLayer()
        setupFirstCircle()
        setupSecondCircle()
        setupRectangle()
        setupVisualEffect()
        setupAnimation()
    }

    private func setupGradientLayer() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.cyan.withAlphaComponent(0.33).cgColor,
                                UIColor.purple.withAlphaComponent(0.11).cgColor]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = .init(x: 1, y: 1)
        gradientLayer.locations = [0, 1]
    }

    private func setupFirstCircle() {
        addSubview(firstCircle)

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        firstCircle.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        firstCircle.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        firstCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66).isActive = true
        firstCircle.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66).isActive = true
        firstCircle.backgroundColor = .blue.withAlphaComponent(0.3)
    }

    private func setupSecondCircle() {
        addSubview(secondCircle)

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)
        layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        secondCircle.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        secondCircle.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        secondCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        secondCircle.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        secondCircle.backgroundColor = .systemPink.withAlphaComponent(0.6)
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

        rectangle.centerXAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        rectangle.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        rectangle.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        rectangle.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65).isActive = true
        rectangle.backgroundColor = .systemMint.withAlphaComponent(0.4)
    }

    private func setupVisualEffect() {
        addSubview(firstVisualEffect)
        firstVisualEffect.set(style: .regular)

        firstVisualEffect.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstVisualEffect.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        firstVisualEffect.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstVisualEffect.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(secondVisualEffect)
        secondVisualEffect.set(style: .light)

        secondVisualEffect.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondVisualEffect.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        secondVisualEffect.topAnchor.constraint(equalTo: topAnchor).isActive = true
        secondVisualEffect.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupAnimation() {
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
