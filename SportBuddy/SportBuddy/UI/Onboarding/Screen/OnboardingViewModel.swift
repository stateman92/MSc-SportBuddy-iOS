//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel: BaseViewModel { }

extension OnboardingViewModel {
    func navigateNext() {
        navigatorService.viewControllers = [DependencyInjector.resolve() as LoginScreen]
    }
}
