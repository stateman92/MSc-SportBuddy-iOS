//
//  OnboardingDomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class OnboardingDomainImpl {
    // MARK: Properties

    @LazyInjected var store: OnboardingStore
    @LazyInjected var action: OnboardingAction
}

// MARK: - OnboardingDomain

extension OnboardingDomainImpl: OnboardingDomain { }
