//
//  NavigatorServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// A protocol for managing the in-app navigation.
protocol NavigatorServiceProtocol: AnyObject {
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

    /// Presents a view controller.
    /// - Parameter screen: the view controller to display over the current view controller’s content.
    /// - Parameter type: the type of the animation.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    @discardableResult func present<T: UIViewController>(_ screen: T,
                                                         type: NavigationType,
                                                         completion: @escaping () -> Void) -> T

    func navigateBack(toViewController: UIViewController?, animated: Bool)
}

extension NavigatorServiceProtocol {
    /// Presents a view controller.
    /// - Parameter screen: the view controller's type to display over the current view controller’s content.
    /// - Parameter type: the type of the animation. By default `.push`.
    /// - Parameter completion: the completion block to execute after the presentation finished. By default does nothing.
    @discardableResult func present<T: UIViewController>(_ screen: T.Type,
                                                         type: NavigationType = .push,
                                                         completion: @escaping () -> Void = { }) -> T {
        present(DependencyInjector.resolve() as T, type: type, completion: completion)
    }

    func navigateBack(toViewController: UIViewController? = nil, animated: Bool = true) {
        navigateBack(toViewController: toViewController, animated: animated)
    }

    func pop(reverseIndex: Int) {
        guard viewControllers.count > reverseIndex else { return }
        let index = viewControllers.count - reverseIndex - 1
        guard viewControllers.indices.contains(index) else { return }
        viewControllers.remove(at: index)
    }

    func resetToDefault() {
        isNavigationBarHidden = true
        viewControllers = [DependencyInjector.resolve() as OnboardingScreen]
    }
}
