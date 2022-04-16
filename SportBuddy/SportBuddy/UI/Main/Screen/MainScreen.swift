//
//  MainScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainScreen: BaseTabScreen<MainViewModel> {
    // MARK: Properties

    @LazyInjected var mainScreenTabs: MainScreenTabs
}

// MARK: - Lifecycle

extension MainScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Setups

extension MainScreen {
    private func setupView() {
        setupTabBar()
        mainScreenTabs.setup(on: self)
    }

    private func setupTabBar() {
        setTabBar(tabBar: MainTabBar())

        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        tabBarItemAppearance.selected.iconColor = .white
        tabBarAppearance.then {
            $0.stackedLayoutAppearance = tabBarItemAppearance
            tabBar.standardAppearance = $0
            tabBar.scrollEdgeAppearance = $0
        }
    }
}
