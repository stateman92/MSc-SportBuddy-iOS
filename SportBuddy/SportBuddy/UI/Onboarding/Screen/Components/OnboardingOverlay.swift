//
//  OnboardingOverlay.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class OnboardingOverlay: View {
    // MARK: Properties

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    let continueButton: UIButton = ButtonLabel(text: "Continue")
    let skipButton: UIButton = ButtonLabel(text: "Skip", style: .secondary)

    // MARK: - Initialization

    override init() {
        super.init()
        setup()
    }
}

// MARK: - Overridden methods

extension OnboardingOverlay {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden,
               subview.alpha > .zero,
               subview.isUserInteractionEnabled,
               subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}

// MARK: - OnboardOverlay

extension OnboardingOverlay: OnboardOverlay {
    func page(count: Int) {
        pageControl.numberOfPages = count
    }

    func currentPage(index: Int) {
        pageControl.currentPage = index
    }
}

// MARK: - Setups

extension OnboardingOverlay {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true

        addSubview(pageControl)
        pageControl.setHeight(16)
        pageControl.anchorToSuperview(leading: .zero, trailing: .zero)
        pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        addSubview(continueButton)
        continueButton.anchorToCenterX()
        continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -16).isActive = true

        addSubview(skipButton)
        skipButton.anchorToTrailing(constant: -32)
        skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
    }
}
