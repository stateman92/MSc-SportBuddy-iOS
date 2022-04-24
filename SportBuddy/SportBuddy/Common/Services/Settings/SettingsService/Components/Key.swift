//
//  Key.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

protocol Key {
    /// The name of the key.
    var keyName: String { get }
}

extension Key where Self == SettingsKey {
    static var token: SettingsKey {
        SettingsKey(keyName: "token", secure: true)
    }

    static var onboarding: SettingsKey {
        SettingsKey(keyName: "onboarding", secure: false)
    }
}
