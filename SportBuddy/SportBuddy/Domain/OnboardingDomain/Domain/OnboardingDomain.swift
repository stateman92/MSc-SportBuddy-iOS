//
//  OnboardingDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class OnboardingDomain {
    @LazyInjected var store: OnboardingStoreProtocol
    @LazyInjected var action: OnboardingActionProtocol
}

extension OnboardingDomain: OnboardingDomainProtocol { }
