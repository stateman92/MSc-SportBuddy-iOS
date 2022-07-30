//
//  BaseViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import Foundation

class BaseViewModel<State: Equatable, Command, Domain: SportBuddy.Domain> {
    // MARK: Properties

    @LazyInjected var navigatorService: NavigatorService
    @LazyInjected var settingService: SettingsService
    @LazyInjected var toastService: ToastService
    @LazyInjected var copyService: CopyService
    @LazyInjected private var domain: Domain
    private let _stateSubject: PassthroughSubject<State, Never> = .init()
    private let stateSubject: CurrentValueSubject<State, Never>

    var cancellables = Cancellables()

    var viewState: CurrentValueSubject<State, Never> {
        stateSubject
    }
    var action: Domain.Action {
        domain.action
    }
    var store: Domain.Store {
        domain.store
    }

    // MARK: Initialization

    init(state: State) {
        stateSubject = .init(state)
        setup()
    }

    convenience init() where State: Initable {
        self.init(state: .init())
    }

    // MARK: - Setup

    @objc dynamic func setup() {
        _stateSubject
            .removeDuplicates()
            .eraseOnMain()
            .assign(to: \.value, on: stateSubject)
            .store(in: &cancellables)

        sendState(stateSubject.value)
    }

    // MARK: - State

    final func sendState(_ state: State) {
        print("ViewModel ---state---> View: \(className(target: self)) sends \(state) state.")
        _stateSubject.send(state)
    }

    // MARK: - Command

    func receiveCommand(_ command: Command) {
        print("View ---command---> ViewModel: \(className(target: self)) receives \(command) command.")
    }

    func createNewState(creation: (State) -> State) {
        sendState(creation(stateSubject.value))
    }
}
