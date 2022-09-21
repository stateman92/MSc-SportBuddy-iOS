//
//  MockSettingsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

final class MockSettingsAction: DomainImpl {
    // MARK: Properties

    @LazyInjected private var navigatorService: NavigatorService
}

// MARK: - SettingsAction

extension MockSettingsAction: SettingsAction {
    func set(image: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }

    func set(batterySaving: Bool) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }

    func logout() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<Void> in
            dispatchToMain {
                self.navigatorService.resetToDefault()
            }
            return .success(())
        }
    }

    func close() -> DomainActionPublisher {
        DeferredFuture { [unowned self] in
            NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
                .delay(for: .milliseconds(150), scheduler: DispatchQueue.main)
                .sink { _ in exit(0) }
                .store(in: &cancellables)

            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            $0(.success(()))
        }
        .autoEraseOnMain()
    }
}
