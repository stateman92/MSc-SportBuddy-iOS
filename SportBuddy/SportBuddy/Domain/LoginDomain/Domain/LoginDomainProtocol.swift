//
//  LoginDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol LoginDomainProtocol: DomainProtocol {
    var store: LoginStoreProtocol { get }
    var action: LoginActionProtocol { get }
}
