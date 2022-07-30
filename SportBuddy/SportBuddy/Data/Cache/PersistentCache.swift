//
//  PersistentCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine

class PersistentCache<Item: Codable>: Cache<Item> {
    // MARK: Properties

    private let key: SettingsKey
    private let secure: Bool
    @LazyInjected private var settingsService: SettingsService

    // MARK: Initialization

    init(key: SettingsKey, secure: Bool = true) {
        self.key = key
        self.secure = secure
        super.init()
        cache.send(settingsService.retrieve(forKey: key))
    }

    convenience init(key: String, secure: Bool = true) {
        self.init(key: SettingsKey(keyName: key, secure: secure), secure: secure)
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented, must be overridden and call super.init(key:secure:).")
    }

    // MARK: - Overridden methods

    override func save(item: Item) {
        super.save(item: item)
        settingsService.save(object: item, forKey: key)
    }

    override func clear() {
        super.clear()
        settingsService.delete(forKey: key)
    }
}
