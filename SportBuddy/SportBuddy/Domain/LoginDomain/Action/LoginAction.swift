//
//  LoginAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LoginAction: Domain {
    @LazyInjected private var loginCache: LoginCache
    @LazyInjected private var tokenCache: TokenCache
}

extension LoginAction: LoginActionProtocol {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<UserResponseDTO> in
            do {
                let result = try await ClientAPI.loginPost(email: email, password: password)
                self?.loginCache.save(item: result.user)
                self?.tokenCache.save(item: result.token)
                return .success(result)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<Void> in
            do {
                try await ClientAPI.refreshTokenPost()
                return .success(())
            } catch {
                self?.loginCache.clear()
                self?.tokenCache.clear()
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
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<UserResponseDTO> in
            do {
                let result = try await ClientAPI.registerPost(name: name, email: email, password: password)
                self?.loginCache.save(item: result.user)
                self?.tokenCache.save(item: result.token)
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
