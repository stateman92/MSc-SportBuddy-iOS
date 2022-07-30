//
//  BaseTabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine
import UIKit

class BaseTabScreen<State,
                    Command,
                    Domain,
                    ViewModel: BaseViewModel<State, Command, Domain>,
                    Tabs: ScreenTabs>: TabBarController {
    // MARK: Properties

    @LazyInjected private var viewModel: ViewModel
    @LazyInjected private var tabs: Tabs
    var cancellables = Cancellables()

    // MARK: - Setups

    override func setupView() {
        super.setupView()
        tabs.setup(on: self)
    }

    override func setupBindings() {
        super.setupBindings()
        viewModel.viewState
            .sink { [unowned self] in receiveState($0) }
            .store(in: &cancellables)
    }

    // MARK: - State

    func receiveState(_ state: State) { }

    // MARK: - Command

    final func sendCommand(_ command: Command) {
        viewModel.receiveCommand(command)
    }
}
