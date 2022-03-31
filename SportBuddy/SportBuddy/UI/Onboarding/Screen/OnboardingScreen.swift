//
//  OnboardingScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class OnboardingScreen: Screen<OnboardingViewModel> {
    let backgroundView = BackgroundView()
    let onboard = Onboard()
}

extension OnboardingScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension OnboardingScreen {
    private func setupView() {
        setupBackgroundView()
        setupOnboard()
    }
}

extension OnboardingScreen {
    private func setupBackgroundView() {
        backgroundView.then {
            view.addSubview($0)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }

    private func setupOnboard() {
        onboard.then {
            onboard.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}

extension OnboardingScreen: OnboardDataSource {
    func onboardNumberOfPages(_ onboard: Onboard) -> Int {
        3
    }

    func onboardOverlayForPosition(_ onboard: Onboard, overlay: OnboardOverlay, for position: Double) {
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
        overlay.continueButton.addAction(.init { [weak self] _ in
            if overlay.continueButton.tag < 2 {
                onboard.goToPage(index: overlay.continueButton.tag + 1, animated: true)
            } else {
                // swiftlint:disable:next multiline_arguments
                UIView.animate(withDuration: 0.5) {
                    self?.onboard.alpha = .zero
                } completion: { _ in
                    self?.onboard.removeFromSuperview()
                }
                self?.backgroundView.finish {
                    self?.backgroundView.removeFromSuperview()
                    self?.viewModel.navigateNext()
                }
            }
        }, for: .touchUpInside)
        overlay.skipButton.addAction(.init { _ in
            onboard.goToPage(index: 2, animated: true)
        }, for: .touchUpInside)
        return overlay
    }

    func onboardPageForIndex(_ onboard: Onboard, index: Int) -> OnboardPage? {
        let page = OnboardingPage()
        page.title.setup(text: "TITLE")
        page.subTitle.setup(text: "SUBTITLE")
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
