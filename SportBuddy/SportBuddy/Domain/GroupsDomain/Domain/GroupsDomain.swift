//
//  GroupsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol GroupsDomain: Domain {
    var store: GroupsStore { get }
    var action: GroupsAction { get }
}
