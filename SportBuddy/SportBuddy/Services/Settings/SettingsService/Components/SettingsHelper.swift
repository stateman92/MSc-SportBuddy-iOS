//
//  SettingsHelper.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 21..
//

enum SettingsHelper {
    @LazyInjected private static var settingsService: SettingsService
}

extension SettingsHelper {
    static func retrieve<T>(forKey key: SettingsKey) -> T? where T: Codable {
        settingsService.retrieve(forKey: key)
    }

    @discardableResult static func save<T>(object: T?, forKey key: SettingsKey) -> Bool where T: Codable {
        settingsService.save(object: object, forKey: key)
    }
}
