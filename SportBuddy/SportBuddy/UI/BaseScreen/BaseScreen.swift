//
//  BaseScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import UIKit

// swiftlint:disable:next operator_usage_whitespace
class BaseScreen<ViewModelState,
                 ViewModelAction,
                 ViewModel: BaseViewModel<ViewModelState, ViewModelAction>>: ViewController {
    // MARK: Properties

    @LazyInjected private var loadingService: LoadingServiceProtocol
    @LazyInjected private var loadingOverlayService: LoadingOverlayServiceProtocol
    @LazyInjected private var viewModel: ViewModel
    var cancellables = Cancellables()

    // MARK: - Lifecycle

    override func setupView() {
        super.setupView()
        loadingService.bind(to: loadingOverlayService)
    }

    override func setupBindings() {
        super.setupBindings()
        viewModel.viewState
            .sink { [unowned self] in receiveState($0) }
            .store(in: &cancellables)
    }

    // MARK: - State

    func receiveState(_ state: ViewModelState) { }

    // MARK: - Action

    final func sendAction(_ action: ViewModelAction) {
        viewModel.receiveAction(action)
    }
}
