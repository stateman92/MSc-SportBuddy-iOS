//
//  LoadingServiceTests.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import Combine
@testable import SportBuddy
import XCTest

final class LoadingServiceTests: XCTestCase {
    // MARK: Properties

    private var sut: LoadingServiceProtocol!
    private var cancellables: Cancellables!
}

// MARK: - Overridden methods

extension LoadingServiceTests {
    override func setUp() {
        super.setUp()
        cancellables = .init()
        sut = LoadingService()
    }
}

// MARK: - Test initial state

extension LoadingServiceTests {
    /// Test the service's initial state.
    func testInitialState() {
        // Given

        // When

        var receivedValues = [Bool]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssertEqual(receivedValues, [false])
    }
}

// MARK: - Test states

extension LoadingServiceTests {
    /// Test the changes in the service's states if the user wants it to be loading.
    func testSetLoading() {
        // Given

        sut.setState(isShowing: true)

        // When

        var receivedValues = [Bool]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssertEqual(receivedValues, [true])
    }

    /// Test the changes in the service's states if the user not wants it to be loading.
    func testSetNotLoading() {
        // Given

        sut.setState(isShowing: false)

        // When

        var receivedValues = [Bool]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssertEqual(receivedValues, [false])
    }

    /// Test the changes in the service's states if the user wants it to be loading multiple times.
    func testSetLoadingMultipleTimes() {
        // Given

        sut.setState(isShowing: true)
        sut.setState(isShowing: true)

        // When

        var receivedValues = [Bool]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssertEqual(receivedValues, [true])
    }
}

// MARK: - Test loading

extension LoadingServiceTests {
    /// Test the changes in the service's states if the user wants it to be loading with closure.
    func testSetLoadingClosure() {
        // Given

        // When

        var receivedValues = [Bool]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        sut.loading { closure in
            closure()
        }

        // Then

        XCTAssertEqual(receivedValues, [false, true, false])
    }
}
