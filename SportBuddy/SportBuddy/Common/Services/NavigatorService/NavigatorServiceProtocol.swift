//
//  NavigatorServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// A protocol for managing the in-app navigation.
protocol NavigatorServiceProtocol: AnyObject, AutoMockable {
    /// Initialize the service.
    /// - Parameter rootViewController: the root view controller.
    init(rootViewController: UIViewController)

    /// Whether the navigation bar is hidden.
    var isNavigationBarHidden: Bool { get set }

    /// The view controllers on the navigation stack.
    var viewControllers: [UIViewController] { get set }

    /// Call to set the navigator as root in the given window.
    /// - Parameter window: the given window.
    func becameRoot(in window: UIWindow)

    /// Presents a view controller modally.
    /// - Parameter viewControllerToPresent: the view controller to display over the current view controller’s content.
    /// - Parameter animated: `true` if you want to animate the presentation, otherwise `false`.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension NavigatorServiceProtocol {
    /// Presents a view controller modally.
    /// - Parameter viewControllerToPresent: the view controller to display over the current view controller’s content.
    /// - Parameter animated: `true` if you want to animate the presentation, otherwise `false`.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: flag, completion: nil)
    }
}
