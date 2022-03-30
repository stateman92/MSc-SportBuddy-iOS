//
//  LoginScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 30..
//

import UIKit

final class LoginScreen: Screen<LoginViewModel> {
    private let backgroundView = BackgroundView()
}

extension LoginScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension LoginScreen {
    private func setupView() {
        backgroundView.alpha = .zero
        view.addSubview(backgroundView)
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        UIView.animate(withDuration: 0.75) {
            self.backgroundView.alpha = 1
        }
    }
}
