//
//  SettingsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

final class SettingsCache: PersistentCache<SettingsCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        var batterySaving: Bool
        var languageSettings: LanguageSettings
    }

    // MARK: Initialization

    required init() {
        super.init(key: .settings, defaultValue: .init(batterySaving: false, languageSettings: .system))
    }
}
