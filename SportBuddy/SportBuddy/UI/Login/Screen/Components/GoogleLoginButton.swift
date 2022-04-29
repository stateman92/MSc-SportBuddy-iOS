//
//  GoogleLoginButton.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 06..
//

import GoogleSignIn

final class GoogleLoginButton: View {
    // MARK: Properties

    private let googleSignInButton = GIDSignInButton()

    // MARK: Initialization

    init(viewController: UIViewController, successfulLogin: @escaping (String) -> Void) {
        super.init()
        setupView(viewController: viewController, successfulLogin: successfulLogin)
    }
}

// MARK: - Private methods

extension GoogleLoginButton {
    private func setupView(viewController: UIViewController, successfulLogin: @escaping (String) -> Void) {
        setupButton(viewController: viewController, successfulLogin: successfulLogin)
    }

    private func setupButton(viewController: UIViewController, successfulLogin: @escaping (String) -> Void) {
        googleSignInButton.then {
            $0.colorScheme = traitCollection.userInterfaceStyle == .dark ? .dark : .light
            $0.style = .wide
            $0.addAction(for: .touchUpInside) {
                GIDSignIn.sharedInstance.signIn(with: AppLoader.signInConfig, presenting: viewController) { user, err in
                    guard err == nil else { return }
                    user?.authentication.do { authentication, error in
                        guard error == nil, let idToken = authentication?.idToken else { return }
                        successfulLogin(idToken)
                    }
                }
            }

            addSubview($0)

            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}
