//
//  InputView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

final class InputView: View {
    enum State {
        case login
        case signUp
    }

    var state: State = .login {
        didSet {
            set(state: state)
        }
    }

    var login: (String, String) -> Void = { _, _ in }
    var signUp: (String, String, String) -> Void = { _, _, _ in }
    var forgotPassword: (String) -> Void = { _ in }

    private let inputStackView = StackView()
    private let nameTextField = StyledTextField()
    private let emailTextField = StyledTextField()
    private let passwordTextField = StyledTextField()
    private let loginRegistrationButton = ButtonLabel(text: "Login")
    private let forgotPasswordButton = ButtonLabel(text: "Forgot password?", style: .tertiary)

    override init() {
        super.init()
        setupView()
    }
}

extension InputView {
    private func setupView() {
        setupInputStackView()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginRegistrationButton()
        setupForgotPasswordButton()
    }
}

extension InputView {
    private func setupInputStackView() {
        inputStackView.then {
            $0.axis = .vertical
            $0.spacing = 24
            $0.alignment = .center

            addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)

            $0.addArrangedSubview(nameTextField)
            $0.addArrangedSubview(emailTextField)
            $0.addArrangedSubview(passwordTextField)
            $0.addArrangedSubview(loginRegistrationButton)
            $0.addArrangedSubview(forgotPasswordButton)
        }
    }

    private func setupNameTextField() {
        nameTextField.then {
            $0.textField.textContentType = .name
            $0.textField.clearButtonMode = .always
            $0.placeholder = "Type your name..."
            $0.isHidden = true
            $0.alpha = .zero

            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor).isActive = true
        }
    }

    private func setupEmailTextField() {
        emailTextField.then {
            $0.textField.textContentType = .username
            $0.textField.clearButtonMode = .always
            $0.placeholder = "Type your email..."

            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor).isActive = true
        }
    }

    private func setupPasswordTextField() {
        passwordTextField.then {
            $0.textField.isSecureTextEntry = true
            $0.textField.clearButtonMode = .always
            $0.placeholder = "Type your password..."

            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor).isActive = true
        }
    }

    private func setupLoginRegistrationButton() {
        loginRegistrationButton.then {
            $0.setWidth(175)
            $0.addAction(.init { [weak self] _ in
                guard let self = self else { return }
                if self.state == .login {
                    self.login(self.emailTextField.text,
                               self.passwordTextField.text)
                } else {
                    self.signUp(self.nameTextField.text,
                                self.emailTextField.text,
                                self.passwordTextField.text)
                }
            }, for: .touchUpInside)
        }
    }

    private func setupForgotPasswordButton() {
        forgotPasswordButton.then {
            $0.addAction(.init { [weak self] _ in
                guard let self = self else { return }
                self.forgotPassword(self.emailTextField.text)
            }, for: .touchUpInside)
        }
    }
}

extension InputView {
    private func set(state: State) {
        UIView.animate(withDuration: 0.5,
                       delay: .zero,
                       options: [.beginFromCurrentState, .allowUserInteraction]) { [self] in
            if state == .login {
                nameTextField.isHidden = true
                nameTextField.alpha = .zero
                loginRegistrationButton.setup(text: "Login")
            } else {
                nameTextField.isHidden = false
                nameTextField.alpha = 1
                loginRegistrationButton.setup(text: "Sign up")
            }
        }
    }
}
