//
//  LoginScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginScreen:
    ScrollingScreen<LoadingViewModelState, LoadingViewModelCommand, LoginDomainImpl, LoginViewModel> {
    // MARK: Properties

    private let segmentedControl = SwipingSegmentedControl()
    private let cardView = CardView()
    private let input = InputView()
}

// MARK: - Lifecycle

extension LoginScreen {
    override func setupView() {
        super.setupView()
        setupSegmentedControl()
        setupCardView()
        setupInput()
    }
}

// MARK: - Setups

extension LoginScreen {
    private func setupSegmentedControl() {
        segmentedControl.then {
            scrollView.addSubview($0)

            $0.segments.append(LabelSegment(
                text: L10n.Login.Segmented.Control.login,
                normalBackgroundColor: .clear,
                normalFont: Fonts.Fredoka.light.font(size: 21),
                normalTextColor: .white,
                selectedFont: Fonts.Fredoka.regular.font(size: 21),
                selectedTextColor: Color.primary.color,
                selectedBackgroundColor: .white))
            $0.segments.append(LabelSegment(
                text: L10n.Login.Segmented.Control.Sign.up,
                normalBackgroundColor: .clear,
                normalFont: Fonts.Fredoka.light.font(size: 21),
                normalTextColor: .white,
                selectedFont: Fonts.Fredoka.regular.font(size: 21),
                selectedTextColor: Color.primary.color,
                selectedBackgroundColor: .white))
            $0.setOptions([.backgroundColor(Color.primary.color.withAlphaComponent(0.5)),
                           .animationSpringDamping(0.66),
                           .indicatorViewInset(2),
                           .cornerRadius(21)])

            $0.addAction(for: .valueChanged) { [weak self] in
                guard let self else { return }
                self.input.state = self.segmentedControl.index == .zero ? .login : .signUp
            }

            $0.anchorToCenterX()
            $0.anchorToTop(constant: 64)
        }
    }

    private func setupCardView() {
        cardView.then {
            scrollView.addSubview($0)

            $0.anchorToCenterX()
            $0.anchorToSuperview(leading: 48, trailing: -48)
            $0.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 64).isActive = true
        }
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        ButtonLabel(text: version, style: .label).then {
            scrollView.addSubview($0)

            $0.anchorToCenterX()
            $0.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 24).isActive = true
        }
    }

    private func setupInput() {
        input.then {
            cardView.add(view: $0, padding: 15)
            $0.login = { [weak self] in
                self?.sendCommand(.login(email: $0, password: $1))
            }
            $0.signUp = { [weak self] in
                self?.sendCommand(.signUp(name: $0, email: $1, password: $2))
            }
            $0.forgotPassword = { [weak self] in
                self?.sendCommand(.forgotPassword(email: $0))
            }
        }
    }
}
