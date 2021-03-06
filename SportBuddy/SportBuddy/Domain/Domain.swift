//
//  Domain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol Domain {
    associatedtype Store
    associatedtype Action

    var store: Store { get }
    var action: Action { get }
}
