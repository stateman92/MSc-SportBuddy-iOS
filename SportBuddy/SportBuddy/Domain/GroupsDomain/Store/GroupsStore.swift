//
//  GroupsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class GroupsStore: Domain {
    @LazyInjected private var groupsCache: GroupsCache
}

extension GroupsStore: GroupsStoreProtocol { }
