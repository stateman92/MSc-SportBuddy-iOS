//
//  OnboardingAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol OnboardingAction {
    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher
}
