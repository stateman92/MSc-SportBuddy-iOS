//
//  MainAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class MainAction: Domain {
    @LazyInjected private var mainCache: MainCache
}

extension MainAction: MainActionProtocol { }
