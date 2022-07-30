//
//  OnboardingStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

final class OnboardingStoreImpl: DomainImpl {
    @LazyInjected private var tokenCache: TokenCache
}

// MARK: - OnboardingStore

extension OnboardingStoreImpl: OnboardingStore {
    var immediateToken: UUID? {
        tokenCache.immediateValue
    }
}
