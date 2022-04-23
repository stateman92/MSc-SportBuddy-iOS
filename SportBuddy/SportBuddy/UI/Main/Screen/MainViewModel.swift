//
//  MainViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class MainViewModel: BaseViewModel {
    override init() {
        super.init()
        navigatorService.isNavigationBarHidden = false
    }
}
