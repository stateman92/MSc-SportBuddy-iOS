//
//  GeneralCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 06. 11..
//

import Combine

enum CacheType {
    case `default`
    case persistent(key: SettingsKey)
}

private enum CacheHolder<Item: Codable> {
    case `default`(cache: Cache<Item>)
    case persistent(persistentCache: PersistentCache<Item>)

    var immediateValue: Item? {
        switch self {
        case let .default(cache):
            return cache.immediateValue
        case let .persistent(persistentCache):
            return persistentCache.immediateValue
        }
    }

    func clear() {
        switch self {
        case let .default(cache):
            cache.clear()
        case let .persistent(persistentCache):
            persistentCache.clear()
        }
    }

    func save(item: Item) {
        switch self {
        case let .default(cache):
            cache.save(item: item)
        case let .persistent(persistentCache):
            persistentCache.save(item: item)
        }
    }

    func modify(_ block: (inout Item) -> Void) {
        switch self {
        case let .default(cache):
            cache.modify(block)
        case let .persistent(persistentCache):
            persistentCache.modify(block)
        }
    }

    func value() -> AnyPublisher<Item?, Never> {
        switch self {
        case let .default(cache):
            return cache.value()
        case let .persistent(persistentCache):
            return persistentCache.value()
        }
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        switch self {
        case let .default(cache):
            return cache.saveWithPublisher(item: item)
        case let .persistent(persistentCache):
            return persistentCache.saveWithPublisher(item: item)
        }
    }

    func modifyWithPublisher(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        switch self {
        case let .default(cache):
            return cache.modifyWithPublisher(block)
        case let .persistent(persistentCache):
            return persistentCache.modifyWithPublisher(block)
        }
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        switch self {
        case let .default(cache):
            return cache.autoEraseOnMain()
        case let .persistent(persistentCache):
            return persistentCache.autoEraseOnMain()
        }
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        switch self {
        case let .default(cache):
            return cache.autoEraseOnMain()
        case let .persistent(persistentCache):
            return persistentCache.autoEraseOnMain()
        }
    }
}

class GeneralCache<Item: Codable> {
    // MARK: Properties

    private let cacheHolder: CacheHolder<Item>

    // MARK: Initialization

    init(cacheType: CacheType = .default) {
        switch cacheType {
        case .default:
            cacheHolder = .default(cache: Cache())
        case let .persistent(key: key):
            cacheHolder = .persistent(persistentCache: PersistentCache(key: key))
        }
    }

    var immediateValue: Item? {
        cacheHolder.immediateValue
    }

    func clear() {
        cacheHolder.clear()
    }

    func save(item: Item) {
        cacheHolder.save(item: item)
    }

    func modify(_ block: @escaping (inout Item) -> Void) {
        cacheHolder.modify(block)
    }

    func value() -> AnyPublisher<Item?, Never> {
        cacheHolder.value()
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        cacheHolder.saveWithPublisher(item: item)
    }

    func modifyWithPublisher(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        cacheHolder.modifyWithPublisher(block)
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        cacheHolder.autoEraseOnMain()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        cacheHolder.autoEraseOnMain()
    }
}
