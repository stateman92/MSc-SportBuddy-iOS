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

private enum Keys: String {
    case token
    case user
    case onboarding
    case settings
}

extension Key where Self == SettingsKey {
    static var token: SettingsKey {
        SettingsKey(keyName: Keys.token, secure: true)
    }

    static var user: SettingsKey {
        SettingsKey(keyName: Keys.user, secure: false)
    }

    static var onboarding: SettingsKey {
        SettingsKey(keyName: Keys.onboarding, secure: false)
    }

    static var settings: SettingsKey {
        SettingsKey(keyName: Keys.settings, secure: false)
    }
}
