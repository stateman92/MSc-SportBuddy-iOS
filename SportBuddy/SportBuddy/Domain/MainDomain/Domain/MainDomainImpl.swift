//
//  MainDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class MainDomainImpl {
    @LazyInjected var store: MainStore
    @LazyInjected var action: MainAction
}

// MARK: - MainDomain

extension MainDomainImpl: MainDomain { }
