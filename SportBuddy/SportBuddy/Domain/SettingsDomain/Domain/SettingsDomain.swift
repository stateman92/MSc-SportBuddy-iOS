//
//  SettingsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol SettingsDomain: Domain {
    var store: SettingsStore { get }
    var action: SettingsAction { get }
}
