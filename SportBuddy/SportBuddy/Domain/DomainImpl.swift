//
//  DomainImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Combine
import Foundation

class DomainImpl {
    // MARK: Nested types

    private enum DomainError: Error {
        case unknown
    }

    // MARK: Properties

    @LazyInjected private var loggingService: LoggingService
    @LazyInjected private var loadingService: LoadingService
    @LazyInjected private var toastService: ToastService
    @LazyInjected private var navigatorService: NavigatorService
    var cancellables = Cancellables()
}

// MARK: - Public methods

extension DomainImpl {
    func log(_ message: String?, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APISuccess: \(message ?? "unknown")\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }

    func log(_ error: Error?, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APIError: \(error ?? DomainError.unknown)\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }

    func log(_ any: Any, file: String = #file, function: String = #function, line: Int = #line) {
        let message = "APISuccess: \(any)\(log(file: file, function: function, line: line))"
        loggingService.debug(message: message)
    }

    func deferredFutureOnMainLoading<T, S>(blocking: Bool = true,
                                           showUnauthenticatedToast: Bool = true,
                                           task: @escaping () async -> Result<S, T>) -> AnyPublisher<Void, T> {
        deferredFutureOnMain(showUnauthenticatedToast: showUnauthenticatedToast) { [unowned self] finish in
            loadingService.loading(blocking: blocking) {
                finish(await task())
            }
        }
    }

    var mockAction: DomainActionPublisher {
        deferredFutureOnMainLoading { () -> DomainActionResult<Void> in
            await wait()
            return .success(())
        }
    }
}

// MARK: - Private methods

extension DomainImpl {
    private func log(file: String, function: String, line: Int) -> String {
        " in \(file), in \(function) at \(line)"
    }

    private func deferredFutureOnMain<T, S>(
        showUnauthenticatedToast: Bool,
        task: @escaping (@escaping (Result<S, T>) -> Void) -> Void) -> AnyPublisher<Void, T> {
            DeferredFuture { [unowned self] future in
                task { [weak self] in
                    self?.handle(result: $0, showUnauthenticatedToast: showUnauthenticatedToast, future: future)
                }
            }.eraseOnMain()
        }

    private func handle<T, S>(result: Result<S, T>, showUnauthenticatedToast: Bool, future: (Result<Void, T>) -> Void) {
        switch result {
        case let .success(success):
            log(success)
            future(.success(()))
        case let .failure(error):
            log(error)
            if (error as? ErrorResponse)?.isUnauthenticated == true {
                forceLoggingOutUser(showUnauthenticatedToast: showUnauthenticatedToast)
            }
            future(.failure(error))
        }
    }

    private func forceLoggingOutUser(showUnauthenticatedToast: Bool) {
        dispatchToMain { [self] in
            navigatorService.reset(to: OnboardingScreen.self)
            if showUnauthenticatedToast {
                toastService.showToast(with: .init(message: L10n.General.Session.expired, type: .error))
            }
        }
    }
}
