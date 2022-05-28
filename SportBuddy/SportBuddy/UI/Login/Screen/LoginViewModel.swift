//
//  LoginViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginViewModel: BaseViewModel<LoadingViewModelState, LoadingViewModelCommand, LoginDomain> {
    // MARK: - Command

    override func receiveCommand(_ command: LoadingViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .login(email, password): login(email: email, password: password)
        case let .signUp(name, email, password): signUp(name: name, email: email, password: password)
        case let .forgotPassword(email): forgotPassword(email: email)
        case let .googleLogin(token): googleLogin(token: token)
        }
    }
}

// MARK: - Setup

extension LoginViewModel {
    override func setup() {
        super.setup()
        if store.immediateToken != nil {
            action
                .refreshToken()
                .sink(receiveValue: { [unowned self] in navigateNext() })
                .store(in: &cancellables)
        }
    }
}

// MARK: - Commands

extension LoginViewModel {
    private func login(email: String, password: String) {
        action
            .login(email: email, password: password)
            .sink(receiveError: { [unowned self] _ in
                toastService.showToast(with: .init(message: "Login failed! Try again later.", type: .error))
            }, receiveValue: { [unowned self] _ in
                toastService.showToast(with: .init(message: "You've logged in successfully!", type: .success))
                navigateNext()
            })
            .store(in: &cancellables)
    }

    private func signUp(name: String, email: String, password: String) {
        action
            .signUp(name: name, email: email, password: password)
            .sink(receiveError: { [unowned self] _ in
                toastService.showToast(with: .init(message: "Registration failed! Try again later.",
                                                   type: .error))
            }, receiveValue: { [unowned self] _ in
                toastService.showToast(with: .init(message: "You've signed up successfully!", type: .success))
                navigateNext()
            })
            .store(in: &cancellables)
    }

    private func forgotPassword(email: String) {
        action
            .forgotPassword(email: email)
            .sink(receiveError: { [unowned self] _ in
                toastService.showToast(
                    with: .init(message: "Forgot password request failed! Try again later.", type: .warning))
            }, receiveValue: { [unowned self] _ in
                toastService.showToast(with: .init(message: "You've requested a password reset email successfully!",
                                                   type: .success))
            })
            .store(in: &cancellables)
    }

    private func googleLogin(token: String) {
    }
}

// MARK: - Private methods

extension LoginViewModel {
    private func navigateNext() {
        navigatorService.present(MainScreen.self, type: .crossDissolve)
    }
}
