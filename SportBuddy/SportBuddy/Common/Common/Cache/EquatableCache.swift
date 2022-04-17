//
//  EquatableCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine

class EquatableCache<Item: Equatable> {
    // MARK: Properties

    var immediateValue: Item? {
        cache.value
    }
    private let triggerOnSameValue: Bool
    private let cache = CurrentValueSubject<Item?, Never>(nil)

    init(triggerOnSameValue: Bool = false) {
        self.triggerOnSameValue = triggerOnSameValue
    }
}

// MARK: Public methods

extension EquatableCache {
    func value() -> AnyPublisher<Item?, Never> {
        cache.eraseToAnyPublisher()
    }

    func clear() {
        cache.send(nil)
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        Future { [weak self] in
            self?.sendIfNecessary(item: item)
            $0(.success(()))
        }.eraseToAnyPublisher()
    }

    func save(item: Item) {
        sendIfNecessary(item: item)
    }
}

extension EquatableCache {
    private func sendIfNecessary(item: Item) {
        if immediateValue != item || (immediateValue == item && triggerOnSameValue) {
            cache.send(item)
        }
    }
}
