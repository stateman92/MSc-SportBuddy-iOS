//
//  OnboardingOverlay.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class OnboardingOverlay: View {
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()

    let continueButton: UIButton = ButtonLabel(text: "Continue")
    let skipButton: UIButton = ButtonLabel(text: "Skip", style: .secondary)

    override init() {
        super.init()
        setup()
    }

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

extension OnboardingOverlay: OnboardOverlay {
    func page(count: Int) {
        pageControl.numberOfPages = count
    }

    func currentPage(index: Int) {
        pageControl.currentPage = index
    }
}

extension OnboardingOverlay {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true

        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 16).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addSubview(continueButton)
        continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -16).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(skipButton)
        skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
    }
}
