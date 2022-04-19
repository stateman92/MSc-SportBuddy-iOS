//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel: BaseViewModel {
    override init() {
        super.init()
        run(settingsService: settingService, key: StringKey(keyName: "onboarding"), times: 3) { } else: {
            navigateNext()
        }
    }
}

// MARK: - Public methods

extension OnboardingViewModel {
    func navigateNext() {
        navigatorService.viewControllers = [DependencyInjector.resolve() as LoginScreen]
    }
}
