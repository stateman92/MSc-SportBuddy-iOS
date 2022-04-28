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
        Deferred { [weak self] in
            Future {
                self?.save(item: item)
                $0(.success(()))
            }
        }.eraseToAnyPublisher()
    }

    func save(item: Item) {
        cache.send(item)
    }

    func modify(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        Deferred { [weak self] in
            Future {
                if let self = self {
                    if var copy = self.cache.value {
                        block(&copy)
                        self.save(item: copy)
                    }
                }
                $0(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}

extension Cache {
    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        value().autoEraseOnMain()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        value().autoEraseOnMain()
    }
}
