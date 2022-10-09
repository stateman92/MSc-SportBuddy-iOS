//
//  QueueTests.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import SportBuddy
import XCTest

final class QueueTests: BaseTestCase {
    // MARK: Properties

    private var queue = Queue<Int>()
}

// MARK: - Tests

extension QueueTests {
    func testInitialState() {
        // Given

        // When

        let count = queue.count

        // Then

        XCTAssert(count == .zero, "The initial state shouldn't contain anything!")
    }

    func testEnqueueValue() {
        // Given

        let item = 5
        queue.enqueue(item)

        // When

        let count = queue.count
        let value = queue.peek()

        // Then

        XCTAssert(count == 1, "The queue should contain one item!")
        XCTAssert(item == value, "The queue first item should be the stored value!")
    }

    func testEnqueueAndPeekingValues() {
        // Given

        let item = 5
        queue.enqueue(item)
        queue.enqueue(6)

        // When

        let count = queue.count
        let value = queue.peek()

        // Then

        XCTAssert(count == 2, "The queue should contain two items!")
        XCTAssert(item == value, "The queue first item should be the stored value!")
    }

    func testQueuingValues() {
        // Given

        let item = 5
        queue.enqueue(item)
        queue.enqueue(6)

        // When

        let countBeforeDequeing = queue.count
        let value = queue.dequeue()
        let countAfterDequeing = queue.count
        queue.dequeue()
        let nilValue = queue.dequeue()

        // Then

        XCTAssert(countBeforeDequeing == 2, "The queue should contain two items!")
        XCTAssert(item == value, "The queue first item should be the stored value!")
        XCTAssert(countAfterDequeing == 1, "After a dequeue the queue should contain one item!")
        XCTAssert(nilValue == nil, "After dequeuing all values the queue shouldn't contain anything!")
    }

    func testDescription() {
        // Given

        let items = [5, 6]
        items.forEach {
            queue.enqueue($0)
        }

        // When

        let description = queue.description

        // Then

        XCTAssert(description == items.description, "The description should be the items' description!")
    }

    func testEquality() {
        // Given

        let items = [5, 6]
        items.forEach {
            queue.enqueue($0)
        }
        let otherQueue = Queue(items: items)

        // When

        let isEqual = queue == otherQueue

        // Then

        XCTAssert(isEqual == true, "The two queues should be equal!")
    }
}
