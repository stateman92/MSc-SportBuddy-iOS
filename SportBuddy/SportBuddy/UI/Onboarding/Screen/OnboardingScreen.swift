//
//  OnboardingScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

// swiftlint:disable:next colon
final class OnboardingScreen:
    BaseScreen<OnboardingViewModelState, OnboardingViewModelCommand, OnboardingDomainImpl, OnboardingViewModel> {
    // MARK: Properties

    let onboard = Onboard()
}

// MARK: - Lifecycle

extension OnboardingScreen {
    override func setupView() {
        super.setupView()
        setupOnboard()
    }
}

// MARK: - Setups

extension OnboardingScreen {
    private func setupOnboard() {
        onboard.then {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - OnboardDataSource

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
            continueButton.setup(text: L10n.Onboarding.continue)
            skipButton.setup(text: L10n.Onboarding.skip)
        } else {
            continueButton.setup(text: L10n.Onboarding.Get.started)
        }
    }

    func onboardViewForOverlay(_ onboard: Onboard) -> OnboardOverlay? {
        let overlay = OnboardingOverlay()
        overlay.continueButton.addAction(for: .touchUpInside) { [weak self] in
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
                    self?.sendCommand(.navigateNext)
                }
            }
        }
        overlay.skipButton.addAction(for: .touchUpInside) {
            onboard.goToPage(index: 2, animated: true)
        }
        return overlay
    }

    func onboardPageForIndex(_ onboard: Onboard, index: Int) -> OnboardPage? {
        let page = OnboardingPage()
        page.title.setup(text: L10n.Onboarding.title)
        page.subTitle.setup(text: L10n.Onboarding.subtitle)
        switch index {
        case 0: page.imageView.image = Images.firstOnboarding.image
        case 1: page.imageView.image = Images.secondOnboarding.image
        default: page.imageView.image = Images.thirdOnboarding.image
        }
        return page
    }
}

// MARK: - OnboardDelegate

extension OnboardingScreen: OnboardDelegate {
    func onboard(_ onboard: Onboard, leftEdge position: Double) {
        onboard.overlay?.skipButton.alpha = 3 - position - 1
    }
}
