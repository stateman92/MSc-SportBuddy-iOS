//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

class BaseViewModel {
    // MARK: Properties

    @LazyInjected var mlService: MLServiceProtocol
    @LazyInjected var navigatorService: NavigatorServiceProtocol
    @LazyInjected var networkService: NetworkServiceProtocol
    @LazyInjected var settingService: SettingsServiceProtocol
}
