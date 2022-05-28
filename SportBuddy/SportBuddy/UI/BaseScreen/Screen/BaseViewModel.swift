//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import Foundation

class BaseViewModel<State, Command, Domain: DomainProtocol> {
    // MARK: Properties

    @LazyInjected var navigatorService: NavigatorServiceProtocol
    @LazyInjected var settingService: SettingsServiceProtocol
    @LazyInjected var toastService: ToastServiceProtocol
    @LazyInjected var copyService: CopyServiceProtocol
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
        print("ViewModel ---state---> View: \(className(target: self)) sends \(state) state.")
        self.state = state
    }

    // MARK: - Command

    func receiveCommand(_ command: Command) {
        print("View ---command---> ViewModel: \(className(target: self)) receives \(command) command.")
    }
}
