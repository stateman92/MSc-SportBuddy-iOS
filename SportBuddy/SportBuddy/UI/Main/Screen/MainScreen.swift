//
//  MainScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainScreen: BaseTabScreen<MainViewModel, MainScreenTabs> {
    // MARK: - Overridden methods

    override func setupTabBarAppearance() {
        super.setupTabBarAppearance()
        setTabBar(tabBar: MainTabBar())

        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        let color = UIColor {
            switch $0.userInterfaceStyle {
            case .dark: return .white
            default: return .darkGray
            }
        }
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor: color]
        tabBarItemAppearance.selected.iconColor = color
        tabBarAppearance.then {
            $0.stackedLayoutAppearance = tabBarItemAppearance
            tabBar.standardAppearance = $0
            tabBar.scrollEdgeAppearance = $0
        }
    }
}

// MARK: - Lifecycle

extension MainScreen {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
