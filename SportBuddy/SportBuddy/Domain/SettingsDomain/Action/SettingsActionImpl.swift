//
//  SettingsActionImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

import UIKit

final class SettingsActionImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var settingsCache: SettingsCache
    @LazyInjected private var userCache: UserCache
    @LazyInjected private var tokenCache: TokenCache
    @LazyInjected private var navigatorService: NavigatorService
}

// MARK: - SettingsAction

extension SettingsActionImpl: SettingsAction {
    func set(image: String) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
            do {
                let user = try await ClientAPI.imagePost(image: image)
                userCache.save(item: .init(user: user))
                return .success(())
            } catch {
                return .failure(error)
            }
        }
    }

    func set(batterySaving: Bool) -> DomainActionPublisher {
        deferredFutureOnMainLoading(blocking: false) { [unowned self] () -> DomainActionResult<Void> in
            settingsCache.save(item: .init(batterySaving: batterySaving))
            return .success(())
        }
    }

    func logout() -> DomainActionPublisher {
        deferredFutureOnMainLoading { [unowned self] () -> DomainActionResult<Void> in
            do {
                try await ClientAPI.logoutPost()
                userCache.clear()
                tokenCache.clear()
                dispatchToMain {
                    self.navigatorService.resetToDefault()
                }
                return .success(())
            } catch {
                return .failure(error)
            }
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
