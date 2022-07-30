//
//  LoginDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol LoginDomain: Domain {
    var store: LoginStore { get }
    var action: LoginAction { get }
}
