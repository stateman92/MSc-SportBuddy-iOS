//
//  CacheTests.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 10. 10..
//

@testable import SportBuddy
import XCTest

final class CacheTests: BaseTestCase {
    // MARK: Properties

    private let cache = Cache<Int>()
    private var cancellables = Cancellables()
}

// MARK: - Tests

extension CacheTests {
    func testInitialValue() {
        // Given

        // When

        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == nil, "The initial value should be nil!")
    }

    func testSaving() {
        // Given

        let data = 5

        // When

        cache.save(item: 6)
        cache.save(item: data)
        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == data, "The value should be the lastly stored value!")
    }

    func testModifying() {
        // Given

        let data = 5

        // When

        cache.save(item: 6)
        cache.modify {
            $0 = data
        }
        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == data, "The value should be the lastly modified value!")
    }

    func testClearing() {
        // Given

        // When

        cache.save(item: 6)
        cache.clear()
        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == nil, "The value after cleaning should be nil!")
    }

    func testSavingPublisher() {
        // Given

        let data = 5

        // When

        cache.saveWithPublisher(item: data)
            .sink()
            .store(in: &cancellables)
        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == data, "The value should be the lastly stored value!")
    }

    func testSavingLaterPublisher() {
        // Given

        let data = 5

        // When

        let saving = cache.saveWithPublisher(item: data)
        let immediateValue = cache.immediateValue
        saving
            .sink()
            .store(in: &cancellables)

        // Then

        XCTAssert(immediateValue == nil, "The saving should be deferred until there is a subscriber for that!")
    }

    func testModifyingPublisher() {
        // Given

        let data = 5

        // When

        cache.save(item: 2)
        cache.modifyWithPublisher { $0 = data }
            .sink()
            .store(in: &cancellables)
        let immediateValue = cache.immediateValue

        // Then

        XCTAssert(immediateValue == data, "The value should be the lastly modified value!")
    }

    func testModifyingLaterPublisher() {
        // Given

        let data = 5

        // When

        let modifying = cache.modifyWithPublisher { $0 = data }
        let immediateValue = cache.immediateValue
        modifying
            .sink()
            .store(in: &cancellables)

        // Then

        XCTAssert(immediateValue == nil, "The modifying should be deferred until there is a subscriber for that!")
    }

    func testValue() {
        // Given

        let data = [5, 6, nil, 11, -1, .zero, nil]

        // When

        var results = [Int?]()
        cache.value()
            .sink { results.append($0) }
            .store(in: &cancellables)
        data.forEach { item in
            if let item {
                cache.save(item: item)
            } else {
                cache.clear()
            }
        }
        let expectedResults = Array(results.dropFirst())

        // Then

        XCTAssert(data == expectedResults, "The stored values must follow the values - without the initial nil!")
    }
}
