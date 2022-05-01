//
//  SettingsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsAction: Domain {
    @LazyInjected private var settingsCache: SettingsCache
}

extension SettingsAction: SettingsActionProtocol { }
