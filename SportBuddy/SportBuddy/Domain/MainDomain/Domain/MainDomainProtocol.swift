//
//  MainDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol MainDomainProtocol: DomainProtocol {
    var store: MainStoreProtocol { get }
    var action: MainActionProtocol { get }
}
