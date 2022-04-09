//
//  NavigationController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

final class NavigationController: UINavigationController { }

extension NavigationController: NavigatorServiceProtocol {
    func becameRoot(in window: UIWindow) {
        window.rootViewController = self
    }
}
