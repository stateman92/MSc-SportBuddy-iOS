//
//  XCTestCase+Extensions.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest

extension XCTestCase {
    /// Wait for some seconds (synchronously).
    /// - Parameter seconds: how many seconds should it waits.
    func wait(for seconds: TimeInterval) {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting")], timeout: seconds)
    }
}
