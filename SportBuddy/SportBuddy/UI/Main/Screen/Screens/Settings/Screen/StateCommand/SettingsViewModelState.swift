//
//  SettingsViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct SettingsViewModelState {
    let image: String
    let name: String
    let items: [[SettingsItem]]
}

extension SettingsViewModelState: Initable {
    init() {
        self.init(image: .init(), name: .init(), items: .init())
    }
}

extension SettingsViewModelState: Equatable { }
