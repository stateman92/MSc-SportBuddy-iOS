//
//  NetworkServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

/// A protocol for managing the network calls.
protocol NetworkServiceProtocol: AutoMockable, Initable {
    /// Initialize the service.
    init()

    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    ///   - completion: the completion handler that is called when the result is available.
    func login(email: String, password: String, completion: @escaping (Result<UserResponseDTO, Error>) -> Void)

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    ///   - completion: the completion handler that is called when the result is available.
    func signUp(name: String,
                email: String,
                password: String,
                completion: @escaping (Result<UserResponseDTO, Error>) -> Void)

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - completion: the completion handler that is called when the result is available.
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
}
