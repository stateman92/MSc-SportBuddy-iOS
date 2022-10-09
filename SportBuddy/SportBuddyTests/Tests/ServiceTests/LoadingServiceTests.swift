//
//  LoadingServiceTests.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import Combine
@testable import SportBuddy
import XCTest

final class LoadingServiceTests: BaseTestCase {
    // MARK: Properties

    private let sut: LoadingService = LoadingServiceImpl()
    private var cancellables = Cancellables()
}

// MARK: - Tests

extension LoadingServiceTests {
    /// Test the service's initial state.
    func testInitialState() {
        // Given

        // When

        var receivedValues = [LoadingState]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssert(receivedValues == [.notLoading])
    }

    /// Test the changes in the service's states if the user wants it to be loading.
    func testSetLoading() {
        // Given

        sut.set(state: .fullScreenLoading)

        // When

        var receivedValues = [LoadingState]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssert(receivedValues == [.fullScreenLoading])
    }

    /// Test the changes in the service's states if the user not wants it to be loading.
    func testSetNotLoading() {
        // Given

        sut.set(state: .notLoading)

        // When

        var receivedValues = [LoadingState]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssert(receivedValues == [.notLoading])
    }

    /// Test the changes in the service's states if the user wants it to be loading multiple times.
    func testSetLoadingMultipleTimes() {
        // Given

        sut.set(state: .fullScreenLoading)
        sut.set(state: .fullScreenLoading)

        // When

        var receivedValues = [LoadingState]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)

        // Then

        XCTAssert(receivedValues == [.fullScreenLoading])
    }

    /// Test the changes in the service's states if the user wants it to be loading with closure.
    func testSetLoadingClosure() {
        // Given

        // When

        var receivedValues = [LoadingState]()
        sut.state
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        sut.loading(blocking: true) { closure in
            closure()
        }

        // Then

        XCTAssert(receivedValues == [.notLoading, .fullScreenLoading, .notLoading])
    }
}
