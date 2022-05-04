//
//  MockOnboardingAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

final class MockOnboardingAction: Domain { }

extension MockOnboardingAction: OnboardingActionProtocol {
    /// Refresh the stored token.
    func refreshToken() -> DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}
