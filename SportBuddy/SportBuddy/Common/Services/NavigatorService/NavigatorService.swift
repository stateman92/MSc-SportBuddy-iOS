//
//  NavigatorService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

import UIKit

/// A class for managing the in-app navigation.
final class NavigatorService {
    // MARK: Properties

    private let navigationController: NavigationController

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameter rootViewController: the root view controller.
    init(rootViewController: UIViewController) {
        navigationController = .init(rootViewController: rootViewController)
    }
}

// MARK: - NavigatorServiceProtocol

extension NavigatorService: NavigatorServiceProtocol {
    /// Whether the navigation bar is hidden.
    var isNavigationBarHidden: Bool {
        get {
            navigationController.isNavigationBarHidden
        }
        set {
            navigationController.isNavigationBarHidden = newValue
        }
    }

    /// The view controllers on the navigation stack.
    var viewControllers: [UIViewController] {
        get {
            navigationController.viewControllers
        }
        set {
            navigationController.viewControllers = newValue
        }
    }

    /// Call to set the navigator as root in the given window.
    /// - Parameter window: the given window.
    func becameRoot(in window: UIWindow) {
        navigationController.becameRoot(in: window)
    }

    /// Presents a view controller modally.
    /// - Parameter viewControllerToPresent: the view controller to display over the current view controller’s content.
    /// - Parameter animated: `true` if you want to animate the presentation, otherwise `false`.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        navigationController.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
