//
//  OnboardingScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class OnboardingScreen: Screen<OnboardingViewModel> {
    let backgroundView = BackgroundView()
    let swiftyOnboard = Onboard()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundView)
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        swiftyOnboard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftyOnboard)
        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
        swiftyOnboard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swiftyOnboard.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        swiftyOnboard.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiftyOnboard.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension OnboardingScreen: OnboardDataSource {
    func onboardNumberOfPages(_ onboard: Onboard) -> Int {
        3
    }

    func onboardOverlayForPosition(_ onboard: Onboard,
                                   overlay: OnboardOverlay,
                                   for position: Double) {
        guard let continueButton = overlay.continueButton as? ButtonLabel,
              let skipButton = overlay.skipButton as? ButtonLabel else { return }

        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)

        if currentPage < 2 {
            continueButton.setup(text: "Continue")
            skipButton.setup(text: "Skip")
        } else {
            continueButton.setup(text: "Get Started!")
        }
    }

    func onboardViewForOverlay(_ onboard: Onboard) -> OnboardOverlay? {
        let overlay = OnboardingOverlay()
        overlay.continueButton.addAction(.init { _ in
            onboard.goToPage(index: overlay.continueButton.tag + 1, animated: true)
        }, for: .touchUpInside)
        overlay.skipButton.addAction(.init { _ in
            onboard.goToPage(index: 2, animated: true)
        }, for: .touchUpInside)
        return overlay
    }

    func onboardPageForIndex(_ onboard: Onboard, index: Int) -> OnboardPage? {
        let page = OnboardingPage()
        page.title.setup(text: "TITLE")
        page.title.setup(style: .label(textColor: .white))
        page.subTitle.setup(text: "SUBTITLE")
        page.subTitle.setup(style: .label(textColor: .black))
        switch index {
        case 0: page.imageView.image = Images.firstOnboarding.image
        case 1: page.imageView.image = Images.secondOnboarding.image
        default: page.imageView.image = Images.thirdOnboarding.image
        }
        return page
    }
}

extension OnboardingScreen: OnboardDelegate {
    func onboard(_ onboard: Onboard, leftEdge position: Double) {
        onboard.overlay?.skipButton.alpha = 3 - position - 1
    }
}
