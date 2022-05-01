//
//  OnboardingActionProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol OnboardingActionProtocol {
    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher
}
