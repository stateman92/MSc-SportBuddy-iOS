//
//  ConnectivityServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 07. 30..
//

import Combine
import Foundation
import Network

/// A class for handling the internet connectivity changes.
final class ConnectivityServiceImpl {
    // MARK: Properties

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "networkMonitoring")
    private let isReachableSubject = CurrentValueSubject<Bool, Never>(false)

    // MARK: Initialization

    /// Initialize the service.
    init() {
        monitor.pathUpdateHandler = { [weak self] in
            guard let self = self else { return }
            self.isReachableSubject.send($0.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}

// MARK: - ConnectivityService

extension ConnectivityServiceImpl: ConnectivityService {
    var isNetworkReachable: AnyPublisher<Bool, Never> {
        isReachableSubject.autoEraseOnMain()
    }
}
