// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import UIKit
@testable import SportBuddy

class NetworkServiceProtocolMock: NetworkServiceProtocol {

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
    //MARK: - login

    var loginEmailPasswordCompletionCallsCount = 0
    var loginEmailPasswordCompletionCalled: Bool {
        return loginEmailPasswordCompletionCallsCount > 0
    }
    var loginEmailPasswordCompletionReceivedArguments: (email: String, password: String, completion: (Result<UserResponseDTO, Error>) -> Void)?
    var loginEmailPasswordCompletionReceivedInvocations: [(email: String, password: String, completion: (Result<UserResponseDTO, Error>) -> Void)] = []
    var loginEmailPasswordCompletionClosure: ((String, String, @escaping (Result<UserResponseDTO, Error>) -> Void) -> Void)?

    func login(email: String, password: String, completion: @escaping (Result<UserResponseDTO, Error>) -> Void) {
        loginEmailPasswordCompletionCallsCount += 1
        loginEmailPasswordCompletionReceivedArguments = (email: email, password: password, completion: completion)
        loginEmailPasswordCompletionReceivedInvocations.append((email: email, password: password, completion: completion))
        loginEmailPasswordCompletionClosure?(email, password, completion)
    }

    //MARK: - signUp

    var signUpNameEmailPasswordCompletionCallsCount = 0
    var signUpNameEmailPasswordCompletionCalled: Bool {
        return signUpNameEmailPasswordCompletionCallsCount > 0
    }
    var signUpNameEmailPasswordCompletionReceivedArguments: (name: String, email: String, password: String, completion: (Result<UserResponseDTO, Error>) -> Void)?
    var signUpNameEmailPasswordCompletionReceivedInvocations: [(name: String, email: String, password: String, completion: (Result<UserResponseDTO, Error>) -> Void)] = []
    var signUpNameEmailPasswordCompletionClosure: ((String, String, String, @escaping (Result<UserResponseDTO, Error>) -> Void) -> Void)?

    func signUp(name: String, email: String, password: String, completion: @escaping (Result<UserResponseDTO, Error>) -> Void) {
        signUpNameEmailPasswordCompletionCallsCount += 1
        signUpNameEmailPasswordCompletionReceivedArguments = (name: name, email: email, password: password, completion: completion)
        signUpNameEmailPasswordCompletionReceivedInvocations.append((name: name, email: email, password: password, completion: completion))
        signUpNameEmailPasswordCompletionClosure?(name, email, password, completion)
    }

    //MARK: - forgotPassword

    var forgotPasswordEmailCompletionCallsCount = 0
    var forgotPasswordEmailCompletionCalled: Bool {
        return forgotPasswordEmailCompletionCallsCount > 0
    }
    var forgotPasswordEmailCompletionReceivedArguments: (email: String, completion: (Result<Void, Error>) -> Void)?
    var forgotPasswordEmailCompletionReceivedInvocations: [(email: String, completion: (Result<Void, Error>) -> Void)] = []
    var forgotPasswordEmailCompletionClosure: ((String, @escaping (Result<Void, Error>) -> Void) -> Void)?

    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        forgotPasswordEmailCompletionCallsCount += 1
        forgotPasswordEmailCompletionReceivedArguments = (email: email, completion: completion)
        forgotPasswordEmailCompletionReceivedInvocations.append((email: email, completion: completion))
        forgotPasswordEmailCompletionClosure?(email, completion)
    }

}
