//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import Foundation

class BaseViewModel<State, Action> {
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

    @ViewModelState private var state: State
    var viewState: AnyPublisher<State, Never> {
        $state.subject
    }

    // MARK: Initialization

    init(state: State) {
        _state = .init(state)
        setup()
    }

    convenience init() where State: Initable {
        self.init(state: .init())
    }

    // MARK: - Setup

    @objc dynamic func setup() { }

    // MARK: - State

    final func sendState(_ state: State) {
        print("ViewModel ---state---> View: \(String(describing: self)) sends \(state) state.")
        self.state = state
    }

    // MARK: - Action

    func receiveAction(_ action: Action) {
        print("View ---action---> ViewModel: \(String(describing: self)) receives \(action) action.")
    }
}
