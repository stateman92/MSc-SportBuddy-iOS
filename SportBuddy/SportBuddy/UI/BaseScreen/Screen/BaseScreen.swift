//
//  BaseScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import UIKit

// swiftlint:disable:next operator_usage_whitespace
class BaseScreen<State,
                 Command,
                 Domain,
                 ViewModel: BaseViewModel<State, Command, Domain>>: ViewController {
    // MARK: Properties

    @LazyInjected private var loadingService: LoadingServiceProtocol
    @LazyInjected private var loadingOverlayService: LoadingOverlayServiceProtocol
    @LazyInjected private var viewModel: ViewModel
    override var isVisible: Bool {
        didSet {
            if !oldValue, isVisible {
                receiveState(viewModel.viewState.value)
            }
        }
    }
    var cancellables = Cancellables()

    // MARK: - Lifecycle

    override func setupView() {
        super.setupView()
        loadingService.bind(to: loadingOverlayService)
    }

    override func setupBindings() {
        super.setupBindings()
        viewModel.viewState
            .filter { [unowned self] _ in isVisible }
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
