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
    func login(email: String, password: String) -> DomainActionPublisher

    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher

    /// Search the registered users.
    func searchUsers(searchTerm: String) -> DomainActionPublisher

    /// Clear the searched users
    func clearSearchedUser() -> DomainActionPublisher

    /// Call to sign up the user.
    /// - Parameters:
    ///   - name: the user's name.
    ///   - email: the user's email.
    ///   - password: the user's password.
    func signUp(name: String, email: String, password: String) -> DomainActionPublisher

    /// Call to sign that the user forgot the password.
    /// - Parameters:
    ///   - email: the user's email.
    func forgotPassword(email: String) -> DomainActionPublisher

    /// Call to login the user with google services.
    func loginWithGoogle() -> DomainActionPublisher
}
