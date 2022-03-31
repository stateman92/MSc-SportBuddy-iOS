//
//  LoginScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginScreen: Screen<LoginViewModel> {
    private let backgroundView = BackgroundView()
    private let segmentedControl = SwipingSegmentedControl()

    private let inputStackView = StackView()
    private let emailInput = TextField()
    private let passwordInput = TextField()
    private let loginRegistrationButton = ButtonLabel(text: "Login")
    private let forgotPasswordButton = ButtonLabel(text: "Forgot password?", style: .tertiary)
}

extension LoginScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension LoginScreen {
    private func setupView() {
        setupBackgroundView()
        setupSegmentedControl()
        setupInputStackView()
        setupLoginRegistrationButton()
    }
}

extension LoginScreen {
    private func setupBackgroundView() {
        backgroundView.then {
            $0.alpha = .zero
            view.addSubview($0)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        UIView.animate(withDuration: 0.75) {
            self.backgroundView.alpha = 1
        }
    }

    private func setupSegmentedControl() {
        segmentedControl.alpha = .zero
        view.addSubview(segmentedControl)

        let palePrimaryColor = Color.primary.color.withAlphaComponent(0.5)
        segmentedControl.segments.append(LabelSegment(
            text: "Log in",
            normalBackgroundColor: .clear,
            normalFont: Fonts.Fredoka.light.font(size: 21),
            normalTextColor: .white,
            selectedFont: Fonts.Fredoka.regular.font(size: 21),
            selectedTextColor: Color.primary.color,
            selectedBackgroundColor: .white))
        segmentedControl.segments.append(LabelSegment(
            text: "Sign up",
            normalBackgroundColor: .clear,
            normalFont: Fonts.Fredoka.light.font(size: 21),
            normalTextColor: .white,
            selectedFont: Fonts.Fredoka.regular.font(size: 21),
            selectedTextColor: Color.primary.color,
            selectedBackgroundColor: .white))
        segmentedControl.setOptions([.backgroundColor(palePrimaryColor),
                                     .animationSpringDamping(0.66),
                                     .indicatorViewInset(2),
                                     .cornerRadius(21)])

        segmentedControl.addAction(.init { [weak self] _ in
            guard let self = self else { return }
            if self.segmentedControl.index == 0 {
                // login
            } else {
                // registration
            }
        }, for: .valueChanged)

        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -128).isActive = true

        UIView.animate(withDuration: 0.75) {
            self.segmentedControl.alpha = 1
        }
    }

    private func setupInputStackView() {
        inputStackView.alpha = .zero
        inputStackView.axis = .vertical
        view.addSubview(inputStackView)
        inputStackView.addArrangedSubview(emailInput)
        inputStackView.addArrangedSubview(passwordInput)
        let spacer = View()
        spacer.heightAnchor.constraint(equalToConstant: 32).isActive = true
        inputStackView.addArrangedSubview(spacer)
        inputStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32).isActive = true

        UIView.animate(withDuration: 0.75) {
            self.inputStackView.alpha = 1
        }
    }

    private func setupLoginRegistrationButton() {
        loginRegistrationButton.alpha = .zero
        view.addSubview(loginRegistrationButton)

        loginRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegistrationButton.centerYAnchor.constraint(equalTo: inputStackView.bottomAnchor).isActive = true

        UIView.animate(withDuration: 0.75) {
            self.loginRegistrationButton.alpha = 1
        }
    }
}
