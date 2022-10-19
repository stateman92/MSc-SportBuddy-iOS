//
//  MockOnboardingAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockOnboardingAction: DomainImpl { }

// MARK: - OnboardingAction

extension MockOnboardingAction: OnboardingAction {
    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        mockAction
    }
}
