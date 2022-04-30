//
//  UserAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine
import Foundation

final class UserAction: Domain {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
    @LazyInjected private var searchedUsersCache: SearchedUsersCache
}

extension UserAction: UserActionProtocol {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<UserResponseDTO> in
            do {
                let result = try await ClientAPI.loginPost(email: email, password: password)
                self?.userCache.save(item: result.user)
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
                self?.userCache.clear()
                self?.tokenCache.clear()
                return .failure(error)
            }
        }
    }

    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<[UserDTO]> in
            do {
                let results = try await ClientAPI.searchUserPost(name: searchTerm)
                self?.searchedUsersCache.save(item: results)
                return .success(results)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [weak self] () -> DomainActionResult<Void> in
            self?.searchedUsersCache.save(item: [])
            return .success(())
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
                self?.userCache.save(item: result.user)
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
