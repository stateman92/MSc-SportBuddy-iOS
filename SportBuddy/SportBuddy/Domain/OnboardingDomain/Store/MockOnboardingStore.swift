//
//  MockOnboardingStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Foundation

final class MockOnboardingStore: Domain { }

extension MockOnboardingStore: OnboardingStoreProtocol {
    var immediateToken: UUID? {
        nil
    }
}
