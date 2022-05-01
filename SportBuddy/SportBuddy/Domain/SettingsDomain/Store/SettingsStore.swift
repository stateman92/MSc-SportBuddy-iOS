//
//  SettingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsStore: Domain {
    @LazyInjected private var settingsCache: SettingsCache
}

extension SettingsStore: SettingsStoreProtocol { }
