//
//  SettingsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsDomain {
    @LazyInjected var store: SettingsStoreProtocol
    @LazyInjected var action: SettingsActionProtocol
}

extension SettingsDomain: SettingsDomainProtocol { }
