//
//  ConnectivityListenerImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 07. 30..
//

import Combine

final class ConnectivityListenerImpl: BaseListenerImpl {
    // MARK: Properties

    @LazyInjected private var connectivityService: ConnectivityService
    @LazyInjected private var toastService: ToastService
}

// MARK: - ConnectivityListener

extension ConnectivityListenerImpl: ConnectivityListener {
    override func start() {
        super.start()
        connectivityService
            .isNetworkReachable
            .removeDuplicates()
            .drop { $0 }
            .map {
                ToastItem(message: $0 ? L10n.General.Connectivity.internet : L10n.General.Connectivity.No.internet,
                          type: $0 ? .success : .error)
            }
            .sink(in: &cancellables) { [unowned self] in toastService.showToast(with: $0) }
    }
}
