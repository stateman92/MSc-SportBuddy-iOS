//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

class BaseViewModel {
    // MARK: Properties

    @LazyInjected var loggingService: LoggingServiceProtocol
    @LazyInjected var mlService: MLServiceProtocol
    @LazyInjected var navigatorService: NavigatorServiceProtocol
    @LazyInjected var settingService: SettingsServiceProtocol
    @LazyInjected var webSocketService: WebSocketServiceProtocol

    @LazyInjected var userDomain: UserDomainProtocol
    @LazyInjected var groupDomain: GroupDomainProtocol
    @LazyInjected var chatDomain: ChatDomainProtocol
    @LazyInjected var trainingDomain: TrainingDomainProtocol

    var cancellables = Cancellables()
}
