//
//  MockLoginAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockLoginAction: DomainImpl { }

// MARK: - LoginAction

extension MockLoginAction: LoginAction {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> DomainActionPublisher {
        mockAction
    }

    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        mockAction
    }

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> DomainActionPublisher {
        mockAction
    }

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}
