//
//  MainViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class MainViewModel: BaseViewModel<MainViewModelState, MainViewModelCommand, MainDomainImpl> {
    // MARK: Properties

    @LazyInjected private var connectivityListener: ConnectivityListener

    // MARK: Initialization

    init() {
        super.init(state: .init())
        connectivityListener.start()
    }
}

// MARK: - Setup

extension MainViewModel {
    override func setup() {
        super.setup()
        navigatorService.isNavigationBarHidden = false
    }
}
