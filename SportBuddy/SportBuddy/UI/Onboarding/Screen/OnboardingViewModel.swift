//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel: BaseViewModel {
    @LazyInjected private var tokenCache: TokenCache

    override init() {
        super.init()

        if tokenCache.immediateValue != nil {
            userAction
                .refreshToken()
                .sink(receiveError: { [unowned self] _ in
                    showOnboarding()
                }, receiveValue: { [unowned self] in
                    navigatorService.present(DependencyInjector.resolve() as MainScreen,
                                             type: .crossDissolve) { [weak self] in
                        self?.navigatorService.viewControllers.removeFirst()
                    }
                })
                .store(in: &cancellables)
        } else {
            showOnboarding()
        }
    }

    private func showOnboarding() {
        settingService.delete(forKey: .token, secure: true)
        run(key: .onboarding, times: 3) { } else: {
            navigateNext()
        }
    }
}

// MARK: - Public methods

extension OnboardingViewModel {
    func navigateNext() {
        navigatorService.present(DependencyInjector.resolve() as LoginScreen, type: .crossDissolve) { [weak self] in
            self?.navigatorService.viewControllers.removeFirst()
        }
    }
}
