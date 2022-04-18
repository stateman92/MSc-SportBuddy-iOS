//
//  UserDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine

final class UserDomain: Domain<UserCache> { }

extension UserDomain: UserDomainProtocol {
    /// The current user.
    var currentUser: AnyPublisher<UserDTO, Never> {
        cache.value().compactMap { $0 }.eraseToAnyPublisher()
    }

    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [weak self] future in
            self?.loadingService.loading { [weak self] in
                do {
                    let result = try await ClientAPI.loginPost(email: email, password: password)
                    self?.cache.save(item: result.user)
                    self?.log(result)
                    future(.success(()))
                } catch {
                    self?.log(error)
                    future(.failure(.loginError))
                }
            }
        }.eraseToAnyPublisher()
    }

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [weak self] future in
            self?.loadingService.loading { finished in
                finished()
                future(.failure(.signUpError))
            }
        }.eraseToAnyPublisher()
    }

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> AnyPublisher<Void, UserDomainError> {
        Future { [weak self] future in
            self?.loadingService.loading { finished in
                finished()
                future(.failure(.forgotPasswordError))
            }
        }.eraseToAnyPublisher()
    }

    func loginWithGoogle() -> AnyPublisher<Void, UserDomainError> {
        Future { [weak self] future in
            self?.loadingService.loading { finished in
                finished()
                future(.failure(.loginWithGoogleError))
            }
        }.eraseToAnyPublisher()
    }
}
