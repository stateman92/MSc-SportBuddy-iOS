//
//  SettingsViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct SettingsViewModelState {
    let items: [SettingsItem]
}

extension SettingsViewModelState: Initable {
    init() {
        self.init(items: .init())
    }
}

extension SettingsViewModelState: Equatable { }
