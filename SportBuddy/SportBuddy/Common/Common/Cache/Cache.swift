//
//  Cache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine

class Cache<Item> {
    // MARK: Properties

    var immediateValue: Item? {
        cache.value
    }
    private let cache = CurrentValueSubject<Item?, Never>(nil)
}

// MARK: Public methods

extension Cache {
    func value() -> AnyPublisher<Item?, Never> {
        cache.eraseToAnyPublisher()
    }

    func clear() {
        cache.send(nil)
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        Future { [weak cache] in
            cache?.send(item)
            $0(.success(()))
        }.eraseToAnyPublisher()
    }

    func save(item: Item) {
        cache.send(item)
    }
}
