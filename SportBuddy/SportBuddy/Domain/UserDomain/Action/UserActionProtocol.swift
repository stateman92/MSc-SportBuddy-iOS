//
//  UserActionProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

import Combine

protocol UserActionProtocol {
    /// Call to login the user.
    /// - Parameters:
    ///   - email: the user's email.
    ///   - password: the user's password.
    func login(email: String, password: String) -> AnyPublisher<Void, UserDomainError>

    /// Refresh the stored token.
    func refreshToken() -> AnyPublisher<Void, UserDomainError>

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> AnyPublisher<Void, UserDomainError>

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> AnyPublisher<Void, UserDomainError>

    /// Call to login the user with google services.
    func loginWithGoogle() -> AnyPublisher<Void, UserDomainError>
}
