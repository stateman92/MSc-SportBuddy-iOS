//
//  OnboardingViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

final class OnboardingViewModel: ViewModel { }

extension OnboardingViewModel {
    func navigateNext() {
        navigator.viewControllers = [DependencyInjector.resolve() as LoginScreen]
    }
}
