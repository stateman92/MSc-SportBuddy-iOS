//
//  ThrottlingTests.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 28..
//

@testable import SportBuddy
import XCTest

final class ThrottlingTests: BaseTestCase {
    // MARK: Properties

    @Throttling(seconds: 0.1) private var throttled: String = .init()
}

// MARK: - Tests

extension ThrottlingTests {
    func testBackingState() {
        // Given

        throttled = "swift"

        // When

        let immediateValue = $throttled.wrappedValue
        wait(for: 0.2)
        let delayedValue = $throttled.wrappedValue

        // Then

        XCTAssert(immediateValue == "swift")
        XCTAssert(delayedValue == "swift")
    }

    func testThrottling() {
        // Given

        throttled = "swift"
        var throttledValue: String?
        $throttled.on { value in
            throttledValue = value
        }

        // When

        wait(for: 0.2)

        // Then

        XCTAssert(throttledValue == "swift")
    }

    func testThrottlingWithoutWaiting() {
        // Given

        var throttledValue = throttled
        $throttled.on { value in
            throttledValue = value
        }
        throttled = "swift"

        // When

        // Then

        XCTAssert(throttledValue.isEmpty == true)
    }

    func testForceThrottling() {
        // Given

        $throttled.force(value: "swift")

        // When

        let immediateValue = throttled

        // Then

        XCTAssert(immediateValue == "swift")
    }

    func testSendJustDistinctValues() {
        // Given

        var throttlingCount = 0
        $throttled.on { _ in
            throttlingCount += 1
        }

        // When

        $throttled.force(value: "swift")
        $throttled.force(value: "swift")
        $throttled.force(value: "swift")

        // Then

        XCTAssert(throttlingCount == 1)
    }

    func testSendNotJustDistinctValues() {
        // Given

        var throttlingCount = 0
        $throttled.on { _ in
            throttlingCount += 1
        }
        $throttled.justDistinctValues = false

        // When

        $throttled.force(value: "swift")
        $throttled.force(value: "swift")
        $throttled.force(value: "swift")

        // Then

        XCTAssert(throttlingCount == 3)
    }
}
