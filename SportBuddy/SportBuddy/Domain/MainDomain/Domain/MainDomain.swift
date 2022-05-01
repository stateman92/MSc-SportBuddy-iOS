//
//  MainDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class MainDomain {
    @LazyInjected var store: MainStoreProtocol
    @LazyInjected var action: MainActionProtocol
}

extension MainDomain: MainDomainProtocol { }
