//
//  GroupsDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol GroupsDomainProtocol: DomainProtocol {
    var store: GroupsStoreProtocol { get }
    var action: GroupsActionProtocol { get }
}
