//
//  DefaultOnboardOverlay.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class DefaultOnboardOverlay: View {
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()

    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()

    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()

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

extension DefaultOnboardOverlay: OnboardOverlay {
    func page(count: Int) {
        pageControl.numberOfPages = count
    }

    func currentPage(index: Int) {
        pageControl.currentPage = index
    }
}

extension DefaultOnboardOverlay {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = true
        addSubview(pageControl)

        let margin = layoutMarginsGuide
        pageControl.setHeight(15)
        pageControl.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -10).isActive = true
        pageControl.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        pageControl.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10).isActive = true

        addSubview(continueButton)
        continueButton.setHeight(20)
        continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        continueButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        continueButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10).isActive = true

        addSubview(skipButton)
        skipButton.setHeight(20)
        skipButton.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10).isActive = true
        skipButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        skipButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -20).isActive = true
    }
}
