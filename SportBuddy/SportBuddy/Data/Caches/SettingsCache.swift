//
//  SettingsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

final class SettingsCache: GeneralCache<SettingsCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        var batterySaving: Bool
        var languageSettings: LanguageSettings
    }

    // MARK: Initialization

    init() {
        super.init(cacheType: .persistent(key: .settings))
    }
}
