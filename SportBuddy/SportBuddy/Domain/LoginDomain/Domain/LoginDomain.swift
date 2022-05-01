//
//  LoginDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class LoginDomain {
    @LazyInjected var store: LoginStoreProtocol
    @LazyInjected var action: LoginActionProtocol
}

extension LoginDomain: LoginDomainProtocol { }
