//
//  LoginDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LoginDomainImpl {
    @LazyInjected var store: LoginStore
    @LazyInjected var action: LoginAction
}

// MARK: - LoginDomain

extension LoginDomainImpl: LoginDomain { }
