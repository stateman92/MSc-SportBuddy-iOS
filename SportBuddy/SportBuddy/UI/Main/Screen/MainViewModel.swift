//
//  MainViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

final class MainViewModel: BaseViewModel<MainViewModelState, MainViewModelCommand, MainDomainImpl> {
    // MARK: Properties

    @LazyInjected private var connectivityListener: ConnectivityListener
    @LazyInjected private var webSocketListener: WebSocketListener
}

// MARK: - Setup

extension MainViewModel {
    override func setup() {
        super.setup()
        setupListeners()
        navigatorService.isNavigationBarHidden = false
    }

    private func setupListeners() {
        connectivityListener.start()
        webSocketListener.start()
    }
}
