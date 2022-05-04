//
//  OnboardingStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import Foundation

final class OnboardingStore: Domain {
    @LazyInjected private var tokenCache: TokenCache
}

extension OnboardingStore: OnboardingStoreProtocol {
    var immediateToken: UUID? {
        tokenCache.immediateValue
    }
}
