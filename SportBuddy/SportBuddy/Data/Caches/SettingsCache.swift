//
//  SettingsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

final class SettingsCache: GeneralCache<SettingsCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let batterySaving: Bool
    }

    // MARK: Initialization

    init() {
        super.init(cacheType: .persistent(key: .settings))
    }
}
