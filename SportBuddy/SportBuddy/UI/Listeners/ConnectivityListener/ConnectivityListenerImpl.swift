//
//  ConnectivityListenerImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 07. 30..
//

import Combine

final class ConnectivityListenerImpl {
    // MARK: Properties

    @LazyInjected private var connectivityService: ConnectivityService
    @LazyInjected private var toastService: ToastService
    private var cancellables = Cancellables()
}

// MARK: - ConnectivityListener

extension ConnectivityListenerImpl: ConnectivityListener {
    func start() {
        connectivityService
            .isNetworkReachable
            .removeDuplicates()
            .drop { $0 }
            .map {
                ToastItem(message: $0 ? "Internet is available!" : "Internet connection is lost!",
                          type: $0 ? .success : .error)
            }
            .sink(in: &cancellables) { [unowned self] in toastService.showToast(with: $0) }
    }
}
