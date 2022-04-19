//
//  GroupDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

final class GroupDomain: Domain {
    @LazyInjected private var groupCache: GroupCache
}

extension GroupDomain: GroupDomainProtocol { }
