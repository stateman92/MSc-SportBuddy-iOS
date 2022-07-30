//
//  ConnectivityService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 07. 30..
//

import Combine

/// A protocol for handling the internet connectivity changes.
protocol ConnectivityService: Initable, AutoMockable {
    /// Check the internet availability.
    var isNetworkReachable: AnyPublisher<Bool, Never> { get }
}
