//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel:
    BaseViewModel<OnboardingViewModelState, OnboardingViewModelCommand, OnboardingDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: OnboardingViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case .navigateNext: navigateNext()
        }
    }
}

// MARK: - Setup

extension OnboardingViewModel {
    override func setup() {
        super.setup()
        if store.immediateToken != nil {
            action
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

// MARK: - Commands

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
