//
//  LoginViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginViewModel: BaseViewModel {
    @LazyInjected private var tokenCache: TokenCache

    override init() {
        super.init()

        toastHandlingService.showToast(with: .init(message: "abc", type: .warning))
        toastHandlingService.showToast(with: .init(message: "abc", type: .error))
        toastHandlingService.showToast(with: .init(message: "abc", type: .success))

        if tokenCache.immediateValue != nil {
            userAction
                .refreshToken()
                .sink(receiveValue: { [unowned self] in
                    navigateNext()
                })
                .store(in: &cancellables)
        }
    }
}

// MARK: - Public methods

extension LoginViewModel {
    func login(email: String, password: String) {
        userAction
            .login(email: email, password: password)
            .sink(receiveError: { [unowned self] _ in
                toastHandlingService.showToast(with: .init(message: "Login failed! Try again later.", type: .error))
            }, receiveValue: { [unowned self] _ in
                toastHandlingService.showToast(with: .init(message: "You've logged in successfully!", type: .success))
                navigateNext()
            })
            .store(in: &cancellables)
    }

    func signUp(name: String, email: String, password: String) {
        userAction
            .signUp(name: name, email: email, password: password)
            .sink(receiveError: { [unowned self] _ in
                toastHandlingService.showToast(with: .init(message: "Registration failed! Try again later.",
                                                           type: .error))
            }, receiveValue: { [unowned self] _ in
                toastHandlingService.showToast(with: .init(message: "You've signed up successfully!", type: .success))
                navigateNext()
            })
            .store(in: &cancellables)
    }

    func forgotPassword(email: String) {
        userAction
            .forgotPassword(email: email)
            .sink(receiveError: { [unowned self] _ in
                toastHandlingService.showToast(
                    with: .init(message: "Forgot password request failed! Try again later.", type: .warning))
            }, receiveValue: { [unowned self] _ in
                toastHandlingService.showToast(with: .init(
                    message: "You've requested a password reset email successfully!",
                    type: .success))
            })
            .store(in: &cancellables)
    }

    func googleLogin(token: String) {
    }
}

extension LoginViewModel {
    private func navigateNext() {
        navigatorService.present(DependencyInjector.resolve() as MainScreen, type: .crossDissolve)
    }
}
