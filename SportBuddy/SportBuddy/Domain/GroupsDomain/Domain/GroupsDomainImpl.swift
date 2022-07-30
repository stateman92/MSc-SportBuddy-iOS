//
//  GroupsDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class GroupsDomainImpl {
    @LazyInjected var store: GroupsStore
    @LazyInjected var action: GroupsAction
}

// MARK: - GroupsDomain

extension GroupsDomainImpl: GroupsDomain { }
