//
//  ScreenTabs.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

/// A protocol for managing tabs in a controller.
protocol ScreenTabs: Initable {
    var viewControllers: [UIViewController] { get }
}

extension ScreenTabs {
    /// Load the tabs to the controller.
    /// - Parameter tabBarController: the controller.
    func setup(on tabBarController: UITabBarController) {
        tabBarController.setViewControllers(viewControllers, animated: false)

        if let selectedViewController = tabBarController.selectedViewController,
           let delegate = tabBarController as? UITabBarControllerDelegate {
            delegate.tabBarController?(tabBarController, didSelect: selectedViewController)
        }
    }
}
