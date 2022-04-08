//
//  NetworkService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine

/// Service for showing loading indicator during network calls.
final class NetworkService {
    @LazyInjected private var loadingService: LoadingServiceProtocol
}

extension NetworkService: NetworkServiceProtocol {
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
