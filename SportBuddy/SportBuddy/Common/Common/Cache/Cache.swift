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
    let cache = CurrentValueSubject<Item?, Never>(nil)

    // MARK: Public methods

    func value() -> AnyPublisher<Item?, Never> {
        cache.eraseToAnyPublisher()
    }

    func clear() {
        cache.send(nil)
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        Future { [weak self] in
            self?.save(item: item)
            $0(.success(()))
        }.eraseToAnyPublisher()
    }

    func save(item: Item) {
        cache.send(item)
    }
}
