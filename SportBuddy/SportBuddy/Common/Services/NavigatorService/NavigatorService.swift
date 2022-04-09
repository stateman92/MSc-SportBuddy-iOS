//
//  NavigatorService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

import UIKit

final class NavigatorService {
    private let navigationController: NavigationController

    init(rootViewController: UIViewController) {
        navigationController = .init(rootViewController: rootViewController)
    }
}

extension NavigatorService: NavigatorServiceProtocol {
    var isNavigationBarHidden: Bool {
        get {
            navigationController.isNavigationBarHidden
        }
        set {
            navigationController.isNavigationBarHidden = newValue
        }
    }

    var viewControllers: [UIViewController] {
        get {
            navigationController.viewControllers
        }
        set {
            navigationController.viewControllers = newValue
        }
    }

    func becameRoot(in window: UIWindow) {
        navigationController.becameRoot(in: window)
    }

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        navigationController.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
