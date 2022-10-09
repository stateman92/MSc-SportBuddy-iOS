//
//  SettingsDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsDomainImpl {
    // MARK: Properties

    @LazyInjected var store: SettingsStore
    @LazyInjected var action: SettingsAction
}

// MARK: - SettingsDomain

extension SettingsDomainImpl: SettingsDomain { }
