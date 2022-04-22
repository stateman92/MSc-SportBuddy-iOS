//
//  GroupAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 22..
//

final class GroupAction: Domain {
    @LazyInjected private var groupCache: GroupCache
}

extension GroupAction: GroupActionProtocol { }
