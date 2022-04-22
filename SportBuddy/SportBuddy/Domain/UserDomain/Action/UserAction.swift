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
}

extension UserAction: UserActionProtocol {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [unowned self] future in
            loadingService.loading { [weak self] in
                do {
                    let result = try await ClientAPI.loginPost(email: email, password: password)
                    self?.userCache.save(item: result.user)
                    self?.tokenCache.save(item: result.token)
                    self?.log(result)
                    future(.success(()))
                } catch {
                    self?.log(error)
                    future(.failure(.loginError))
                }
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }

    /// Refresh the stored token.
    func refreshToken() -> AnyPublisher<Void, UserDomainError> {
        Future { [unowned self] future in
            loadingService.loading { [weak self] in
                do {
                    try await ClientAPI.refreshTokenPost()
                    self?.log("success")
                    future(.success(()))
                } catch {
                    self?.log(error)
                    future(.failure(.refreshTokenError))
                }
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [unowned self] future in
            loadingService.loading { [weak self] in
                do {
                    let result = try await ClientAPI.registerPost(name: name, email: email, password: password)
                    self?.userCache.save(item: result.user)
                    self?.tokenCache.save(item: result.token)
                    self?.log(result)
                    future(.success(()))
                } catch {
                    self?.log(error)
                    future(.failure(.signUpError))
                }
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [unowned self] future in
            loadingService.loading { [weak self] in
                do {
                    try await ClientAPI.forgotPasswordPost(email: email)
                    self?.log("success")
                    future(.success(()))
                } catch {
                    self?.log(error)
                    future(.failure(.forgotPasswordError))
                }
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }

    /// Call to login the user with google services.
    func loginWithGoogle() -> AnyPublisher<Void, UserDomainError> {
        Future { [unowned self] future in
            loadingService.loading { finished in
                finished()
                future(.failure(.loginWithGoogleError))
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
