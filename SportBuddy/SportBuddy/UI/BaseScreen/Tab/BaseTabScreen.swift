//
//  BaseTabScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine
import UIKit

class BaseTabScreen<ViewModel: BaseViewModel, Tabs: ScreenTabs>: UITabBarController, UITabBarControllerDelegate {
    // MARK: Properties

    @LazyInjected var viewModel: ViewModel
    @LazyInjected var toastHandlingService: ToastHandlingServiceProtocol
    @LazyInjected private var tabs: Tabs
    var cancellables = Cancellables()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.title = viewController.title
        navigationItem.titleView = viewController.navigationItem.titleView
        navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems
        navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
        navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems
        navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
        navigationItem.backBarButtonItem = viewController.navigationItem.backBarButtonItem
        navigationItem.hidesBackButton = viewController.navigationItem.hidesBackButton
    }

    // MARK: - Overridable methods

    func setupTabBarAppearance() { }
}

// MARK: - Public methods

extension BaseTabScreen {
    func setTabBar(tabBar: UITabBar) {
        setValue(tabBar, forKey: "tabBar")
    }
}

// MARK: - Setups

extension BaseTabScreen {
    private func setupView() {
        setupTabBarAppearance()
        delegate = self
        tabs.setup(on: self)
    }
}
