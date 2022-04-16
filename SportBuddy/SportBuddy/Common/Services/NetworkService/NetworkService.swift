//
//  NetworkService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine

/// A class for managing the network calls.
final class NetworkService {
    // MARK: Properties

    @LazyInjected private var loadingService: LoadingServiceProtocol

    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    ///   - completion: the completion handler that is called when the result is available.
    func login(email: String, password: String, completion: @escaping (Result<UserResponseDTO, Error>) -> Void) {
        loadingService.loading { finished in
            ClientAPI.loginPost(email: email, password: password) { data, error in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error ?? NetworkError.unknown))
                }
                finished()
            }
        }
    }

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    ///   - completion: the completion handler that is called when the result is available.
    func signUp(name: String,
                email: String,
                password: String,
                completion: @escaping (Result<UserResponseDTO, Error>) -> Void) {
        loadingService.loading { finished in
            ClientAPI.registerPost(name: name, email: email, password: password) { data, error in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error ?? NetworkError.unknown))
                }
                finished()
            }
        }
    }

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - completion: the completion handler that is called when the result is available.
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        loadingService.loading { finished in
            ClientAPI.forgotPasswordPost(email: email) { data, error in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error ?? NetworkError.unknown))
                }
                finished()
            }
        }
    }
}
