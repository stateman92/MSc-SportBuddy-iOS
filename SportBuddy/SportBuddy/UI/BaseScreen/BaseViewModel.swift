//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import Foundation

class BaseViewModel<State, Action, Domain: DomainProtocol> {
    // MARK: Properties

    @LazyInjected var navigatorService: NavigatorServiceProtocol
    @LazyInjected var settingService: SettingsServiceProtocol
    @LazyInjected var toastHandlingService: ToastServiceProtocol
    @LazyInjected private var domain: Domain

    var cancellables = Cancellables()

    @ViewModelState private var state: State
    var viewState: AnyPublisher<State, Never> {
        $state.subject
    }
    var action: Domain.Action {
        domain.action
    }
    var store: Domain.Store {
        domain.store
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
