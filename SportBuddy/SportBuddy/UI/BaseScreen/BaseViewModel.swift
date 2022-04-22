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
    @LazyInjected var toastHandlingService: ToastServiceProtocol
    @LazyInjected var webSocketService: WebSocketServiceProtocol

    @LazyInjected var userAction: UserActionProtocol
    @LazyInjected var userStore: UserStoreProtocol
    @LazyInjected var groupAction: GroupActionProtocol
    @LazyInjected var groupStore: GroupStoreProtocol
    @LazyInjected var chatAction: ChatActionProtocol
    @LazyInjected var chatStore: ChatStoreProtocol
    @LazyInjected var trainingAction: TrainingActionProtocol
    @LazyInjected var trainingStore: TrainingStoreProtocol

    var cancellables = Cancellables()
}
