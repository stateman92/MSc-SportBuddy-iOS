//
//  LoginViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginViewModel: BaseViewModel { }

extension LoginViewModel {
    func login(email: String, password: String) {
        networkService.login(email: email, password: password) { [weak self] result in
            switch result {
            case let .success(userResponse):
                self?.navigator.viewControllers = [UIViewController()]
            case let .failure(error):
                dump(error)
            }
        }
    }

    func signUp(name: String, email: String, password: String) {
        networkService.signUp(name: name, email: email, password: password) { [weak self] result in
            switch result {
            case let .success(userResponse):
                self?.navigator.viewControllers = [UIViewController()]
            case let .failure(error):
                dump(error)
            }
        }
    }

    func forgotPassword(email: String) {
        networkService.forgotPassword(email: email) { [weak self] result in
            switch result {
            case let .success(userResponse):
                self?.navigator.viewControllers = [UIViewController()]
            case let .failure(error):
                dump(error)
            }
        }
    }

    func googleLogin(token: String) {
    }
}
