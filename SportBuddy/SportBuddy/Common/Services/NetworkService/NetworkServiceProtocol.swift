//
//  NetworkServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

/// A protocol for managing the network calls.
protocol NetworkServiceProtocol: AutoMockable {
    init()
    func login(email: String, password: String, completion: @escaping (Result<UserResponseDTO, Error>) -> Void)
    func signUp(name: String,
                email: String,
                password: String,
                completion: @escaping (Result<UserResponseDTO, Error>) -> Void)
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
}
