//
//  MainScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class MainScreen: CustomTabbedTabScreen<MainViewModel, MainScreenTabs> {
    // MARK: Initialization

    init() {
        super.init(selectedColor: UIColor {
            switch $0.userInterfaceStyle {
            case .dark: return .white
            default: return .darkGray
            }
        }, unselectedColor: .systemGray)

        toastHandlingService.showToast(with: .init(message: "Success Success Success Success Success", type: .success))
        toastHandlingService.showToast(with: .init(message: "Warning Warning Warning Warning Warning ", type: .warning))
        toastHandlingService.showToast(with: .init(message: "Error Error Error Error Error Error Error ", type: .error))
    }

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
