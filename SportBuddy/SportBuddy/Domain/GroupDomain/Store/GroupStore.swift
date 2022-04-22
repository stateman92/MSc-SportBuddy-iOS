//
//  GroupStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class GroupStore: Domain {
    @LazyInjected private var groupCache: GroupCache
}

extension GroupStore: GroupStoreProtocol { }
