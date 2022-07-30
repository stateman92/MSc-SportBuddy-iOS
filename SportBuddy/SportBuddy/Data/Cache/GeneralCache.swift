//
//  GeneralCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 06. 11..
//

import Combine

enum CacheType {
    case `default`
    case persistent(key: SettingsKey, secure: Bool = true)
}

private enum CacheHolder<Item: Codable> {
    case `default`(cache: Cache<Item>)
    case persistent(persistentCache: PersistentCache<Item>)

    var immediateValue: Item? {
        switch self {
        case .default(let cache):
            return cache.immediateValue
        case .persistent(let persistentCache):
            return persistentCache.immediateValue
        }
    }

    func clear() {
        switch self {
        case .default(let cache):
            cache.clear()
        case .persistent(let persistentCache):
            persistentCache.clear()
        }
    }

    func save(item: Item) {
        switch self {
        case .default(let cache):
            cache.save(item: item)
        case .persistent(let persistentCache):
            persistentCache.save(item: item)
        }
    }

    func value() -> AnyPublisher<Item?, Never> {
        switch self {
        case .default(let cache):
            return cache.value()
        case .persistent(let persistentCache):
            return persistentCache.value()
        }
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        switch self {
        case .default(let cache):
            return cache.saveWithPublisher(item: item)
        case .persistent(let persistentCache):
            return persistentCache.saveWithPublisher(item: item)
        }
    }

    func modify(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        switch self {
        case .default(let cache):
            return cache.modify(block)
        case .persistent(let persistentCache):
            return persistentCache.modify(block)
        }
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        switch self {
        case .default(let cache):
            return cache.autoEraseOnMain()
        case .persistent(let persistentCache):
            return persistentCache.autoEraseOnMain()
        }
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        switch self {
        case .default(let cache):
            return cache.autoEraseOnMain()
        case .persistent(let persistentCache):
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
        case let .persistent(key: key, secure: secure):
            cacheHolder = .persistent(persistentCache: PersistentCache(key: key, secure: secure))
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

    func value() -> AnyPublisher<Item?, Never> {
        cacheHolder.value()
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        cacheHolder.saveWithPublisher(item: item)
    }

    func modify(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        cacheHolder.modify(block)
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        cacheHolder.autoEraseOnMain()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        cacheHolder.autoEraseOnMain()
    }
}
