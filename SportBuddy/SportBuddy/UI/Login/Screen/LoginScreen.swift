//
//  LoginScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginScreen: ScrollingScreen<LoginViewModel> {
    private let backgroundView = BackgroundView()
    private let segmentedControl = SwipingSegmentedControl()

    private let cardView = CardView()
    private let input = InputView()
    private let orView = View()
    private lazy var googleLoginButton = GoogleLoginButton(viewController: self) { [weak self] token in
        self?.viewModel.googleLogin(token: token)
    }
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
        setupCardView()
        setupInput()
        setupOrView()
        setupGoogleLoginButton()

        setupInitialAnimation()
    }
}

extension LoginScreen {
    private func setupBackgroundView() {
        backgroundView.then {
            view.addSubview($0)
            view.sendSubviewToBack($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }

    private func setupSegmentedControl() {
        segmentedControl.then {
            scrollView.addSubview($0)

            $0.segments.append(LabelSegment(
                text: "Log in",
                normalBackgroundColor: .clear,
                normalFont: Fonts.Fredoka.light.font(size: 21),
                normalTextColor: .white,
                selectedFont: Fonts.Fredoka.regular.font(size: 21),
                selectedTextColor: Color.primary.color,
                selectedBackgroundColor: .white))
            $0.segments.append(LabelSegment(
                text: "Sign up",
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

            $0.addAction(.init { [weak self] _ in
                guard let self = self else { return }
                self.input.state = self.segmentedControl.index == 0 ? .login : .signUp
            }, for: .valueChanged)

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
    }

    private func setupInput() {
        input.then {
            cardView.add(view: $0, padding: 15)
            $0.login = { [weak self] in
                self?.viewModel.login(email: $0, password: $1)
            }
        }
    }

    private func setupOrView() {
        let stackView = StackView().then {
            let firstDash = View().then {
                $0.backgroundColor = .white
                $0.setHeight(2)
                $0.setWidth(45)
                $0.layer.cornerRadius = 1
            }
            let orLabel = Label().then {
                $0.text = "OR"
                $0.textColor = .white
            }
            let secondDash = View().then {
                $0.backgroundColor = .white
                $0.setHeight(2)
                $0.setWidth(45)
                $0.layer.cornerRadius = 1
            }
            $0.addArrangedSubview(firstDash)
            $0.addArrangedSubview(orLabel)
            $0.addArrangedSubview(secondDash)

            $0.spacing = 8
            $0.alignment = .center
        }

        orView.then {
            scrollView.addSubview($0)

            $0.anchorToCenterX()
            $0.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32).isActive = true

            $0.addSubview(stackView)
            stackView.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }

    private func setupGoogleLoginButton() {
        googleLoginButton.then {
            scrollView.addSubview($0)

            $0.anchorToCenterX()
            $0.anchorToBottom()
            $0.topAnchor.constraint(equalTo: orView.bottomAnchor, constant: 32).isActive = true
        }
    }

    private func setupInitialAnimation() {
        view.subviews.forEach { view in
            view.alpha = .zero

            UIView.animate(withDuration: 0.75) {
                view.alpha = 1
            }
        }
    }
}
