//
//  BaseScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import UIKit

class BaseScreen<ViewModel: BaseViewModel>: UIViewController {
    // MARK: Properties

    @LazyInjected private var loadingService: LoadingServiceProtocol
    @LazyInjected private var loadingOverlayService: LoadingOverlayServiceProtocol
    @LazyInjected var viewModel: ViewModel
    var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background.color
        loadingService.bind(to: loadingOverlayService)
        hideKeyboardWhenTappedOutside()
    }
}
