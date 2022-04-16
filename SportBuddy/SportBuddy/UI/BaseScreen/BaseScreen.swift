//
//  BaseScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import UIKit

class BaseScreen<ViewModel: BaseViewModel>: UIViewController {
    // MARK: Nested types

    struct BackgroundViewOptions {
        var showing = true
        var animating = true
    }

    // MARK: Properties

    @LazyInjected private var loadingService: LoadingServiceProtocol
    @LazyInjected private var loadingOverlayService: LoadingOverlayServiceProtocol
    @LazyInjected var viewModel: ViewModel
    var cancellables = Cancellables()
    var backgroundViewOptions = BackgroundViewOptions() {
        didSet {
            updateBackgroundView()
        }
    }
    let backgroundView = BackgroundView()
    override var title: String? {
        didSet {
            tabBarItem.title = title
        }
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setups

extension BaseScreen {
    private func setupView() {
        view.backgroundColor = Color.background.color
        loadingService.bind(to: loadingOverlayService)
        hideKeyboardWhenTappedOutside()
        updateBackgroundView()
    }
}

// MARK: - Private methods

extension BaseScreen {
    private func updateBackgroundView() {
        if backgroundViewOptions.showing, backgroundView.superview == nil {
            backgroundView.then {
                view.addSubview($0)
                view.sendSubviewToBack($0)
                $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
            }
        } else if !backgroundViewOptions.showing, backgroundView.superview != nil {
            backgroundView.removeFromSuperview()
        }

        backgroundView.isAnimating = backgroundViewOptions.animating
    }
}
