//
//  LoginActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LoginActionImpl: DomainImpl {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
}

// MARK: - LoginAction

extension LoginActionImpl: LoginAction {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<UserResponseDTO> in
            do {
                let result = try await ClientAPI.loginPost(email: email, password: password)
                userCache.save(item: result.user)
                tokenCache.save(item: result.token)
                return .success(result)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        deferredFutureOnMainLoading(
            showUnauthenticatedToast: tokenCache.immediateValue != nil
        ) { [unowned self] () -> DomainActionResult<Void> in
            do {
                try await ClientAPI.refreshTokenPost()
                return .success(())
            } catch {
                userCache.clear()
                tokenCache.clear()
                return .failure(error)
            }
        }
    }

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<UserResponseDTO> in
            do {
                let result = try await ClientAPI.registerPost(name: name, email: email, password: password)
                userCache.save(item: result.user)
                tokenCache.save(item: result.token)
                return .success(result)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
            do {
                try await ClientAPI.forgotPasswordPost(email: email)
                return .success(())
            } catch {
                return .failure(error)
            }
        }
    }

    /// Call to login the user with google services.
    func loginWithGoogle() -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
                .success(())
        }
    }
}
