//
//  SettingsKey.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

struct SettingsKey: Key {
    let keyName: String
    let secure: Bool
}

extension SettingsKey {
    init<T>(keyName: T, secure: Bool) where T: RawRepresentable, T.RawValue == String {
        self.init(keyName: keyName.rawValue, secure: secure)
    }
}

extension SettingsKey {
    var asDefaultSettingsKey: DefaultSettingsKey {
        guard !secure || isSimulator else {
            preconditionFailure("A secure key shouldn't be obtained as a DefaultSettingsKey.")
        }
        return .init(keyName: keyName)
    }

    var asSecureSettingsKey: SecureSettingsKey {
        guard secure else {
            preconditionFailure("A non-secure key shouldn't be obtained as a SecureSettingsKey.")
        }
        return .init(keyName: keyName)
    }
}
