//
//  OnboardingAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class OnboardingAction: Domain {
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
}

extension OnboardingAction: OnboardingActionProtocol {
    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        deferredFutureOnMainLoading(
            showUnauthenticatedToast: tokenCache.immediateValue != nil
        ) { [weak self] () -> DomainActionResult<Void> in
            do {
                try await ClientAPI.refreshTokenPost()
                return .success(())
            } catch {
                self?.userCache.clear()
                self?.tokenCache.clear()
                return .failure(error)
            }
        }
    }
}
