//
//  MainViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class MainViewModel: BaseViewModel<MainViewModelState, MainViewModelAction, MainDomain> { }

// MARK: - Setup

extension MainViewModel {
    override func setup() {
        super.setup()
        navigatorService.isNavigationBarHidden = false
    }
}
