//
//  PersistentCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine

class PersistentCache<Item: Codable>: Cache<Item> {
    // MARK: Properties

    private let key: Key
    private let secure: Bool
    @LazyInjected private var settingsService: SettingsServiceProtocol

    // MARK: Initialization

    init(key: Key, secure: Bool = true) {
        self.key = key
        self.secure = secure
    }

    init(key: String, secure: Bool = true) {
        self.key = StringKey(keyName: key)
        self.secure = secure
    }

    // MARK: - Overridden methods

    override func save(item: Item) {
        super.save(item: item)
        settingsService.save(object: item, forKey: key, secure: secure)
    }

    override func clear() {
        super.clear()
        settingsService.delete(forKey: key, secure: secure)
    }
}
