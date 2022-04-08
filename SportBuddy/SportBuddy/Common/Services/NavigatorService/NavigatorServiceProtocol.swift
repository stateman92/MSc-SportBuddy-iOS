//
//  NavigatorServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// A protocol for managing the in-app navigation.
protocol NavigatorServiceProtocol: AnyObject, AutoMockable {
    init(rootViewController: UIViewController)

    var isNavigationBarHidden: Bool { get set }
    var viewControllers: [UIViewController] { get set }

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
