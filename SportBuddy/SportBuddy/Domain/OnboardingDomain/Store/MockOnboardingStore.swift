//
//  MockOnboardingStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Foundation

final class MockOnboardingStore: DomainImpl { }

// MARK: - OnboardingStore

extension MockOnboardingStore: OnboardingStore {
    var immediateToken: UUID? {
        nil
    }
}
