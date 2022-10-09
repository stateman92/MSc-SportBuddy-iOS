//
//  BaseTestCase.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

@testable import SportBuddy
import XCTest

class BaseTestCase: XCTestCase { }

// MARK: - Overridden methods

extension BaseTestCase {
    override class func setUp() {
        super.setUp()
        DependencyInjector.registerDependenciesForTests()
    }
}
