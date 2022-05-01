//
//  SettingsDomainProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol SettingsDomainProtocol: DomainProtocol {
    var store: SettingsStoreProtocol { get }
    var action: SettingsActionProtocol { get }
}
