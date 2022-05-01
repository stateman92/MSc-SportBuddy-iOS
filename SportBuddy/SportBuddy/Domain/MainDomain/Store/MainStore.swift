//
//  MainStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class MainStore: Domain {
    @LazyInjected private var mainCache: MainCache
}

extension MainStore: MainStoreProtocol { }
