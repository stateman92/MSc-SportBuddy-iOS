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
    @LazyInjected private var loggingService: LoggingService

    // MARK: Initialization

    required init() { }

    // MARK: Overridable methods

    func clear() {
        cache.send(nil)
    }

    func save(item: Item) {
        cache.send(item)
    }

    func modify(_ block: (inout Item) -> Void) {
        if var immediateValue {
            block(&immediateValue)
            save(item: immediateValue)
        } else {
            loggingService.default(
                message: "WARNING: nil value wanted to be modified, there is a possibility of a silent bug!")
        }
    }
}

// MARK: - Public methods

extension Cache {
    func value() -> AnyPublisher<Item?, Never> {
        cache.eraseToAnyPublisher()
    }

    func saveWithPublisher(item: Item) -> AnyPublisher<Void, Never> {
        DeferredFuture { [unowned self] in
            save(item: item)
            $0(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func modifyWithPublisher(_ block: @escaping (inout Item) -> Void) -> AnyPublisher<Void, Never> {
        DeferredFuture { [unowned self] in
            modify(block)
            $0(.success(()))
        }
        .eraseToAnyPublisher()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item> {
        value().autoEraseOnMain()
    }

    func autoEraseOnMain() -> DomainStorePublisher<Item?> {
        value().autoEraseOnMain()
    }
}
