//
//  SportBuddyUITests.swift
//  SportBuddyUITests
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import XCTest

final class SportBuddyUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
