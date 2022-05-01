//
//  GroupsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class GroupsAction: Domain {
    @LazyInjected private var groupsCache: GroupsCache
}

extension GroupsAction: GroupsActionProtocol { }
