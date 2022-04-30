//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel: BaseViewModel<OnboardingViewModelState, OnboardingViewModelAction> {
    // MARK: Properties

    @LazyInjected private var tokenCache: TokenCache

    // MARK: - Action

    override func receiveAction(_ action: OnboardingViewModelAction) {
        super.receiveAction(action)
        switch action {
        case .navigateNext: navigateNext()
        }
    }
}

// MARK: - Setup

extension OnboardingViewModel {
    override func setup() {
        super.setup()
        if tokenCache.immediateValue != nil {
            userAction
                .refreshToken()
                .sink(receiveError: { [unowned self] _ in
                    showOnboarding()
                }, receiveValue: { [unowned self] in
                    navigatorService.present(MainScreen.self, type: .crossDissolve) { [weak self] in
                        self?.navigatorService.viewControllers.removeFirst()
                    }
                })
                .store(in: &cancellables)
        } else {
            showOnboarding()
        }
    }
}

// MARK: - Actions

extension OnboardingViewModel {
    private func navigateNext() {
        navigatorService.present(LoginScreen.self, type: .crossDissolve) { [weak self] in
            self?.navigatorService.viewControllers.removeFirst()
        }
    }
}

// MARK: - Private methods

extension OnboardingViewModel {
    private func showOnboarding() {
        settingService.delete(forKey: .token)
        run(key: .onboarding, times: 3) { } else: {
            navigateNext()
        }
    }
}
