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

    // MARK: Initialization

    required init() { }

    // MARK: Overridable methods

    func value() -> AnyPublisher<Item?, Never> {
        cache.eraseToAnyPublisher()
    }

    func clear() {
        cache.send(nil)
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        DeferredFuture { [unowned self] in
            save(item: item)
            $0(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func save(item: Item) {
        cache.send(item)
    }

    func modify(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        DeferredFuture { [unowned self] in
            if var copy = cache.value {
                block(&copy)
                save(item: copy)
            }
            $0(.success(()))
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Public methods

extension Cache {
    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        value().autoEraseOnMain()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        value().autoEraseOnMain()
    }
}
