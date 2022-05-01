//
//  GroupsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class GroupsDomain {
    @LazyInjected var store: GroupsStoreProtocol
    @LazyInjected var action: GroupsActionProtocol
}

extension GroupsDomain: GroupsDomainProtocol { }
