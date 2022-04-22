//
//  NavigationController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

final class NavigationController: UINavigationController { }

extension NavigationController: NavigatorServiceProtocol {
    /// Call to set the navigator as root in the given window.
    /// - Parameter window: the given window.
    func becameRoot(in window: UIWindow) {
        window.rootViewController = self
    }

    /// Presents a view controller.
    /// - Parameter screen: the view controller to display over the current view controller’s content.
    /// - Parameter type: the type of the animation.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    func present(_ screen: UIViewController, type: NavigationType, completion: @escaping () -> Void) {
        switch type {
        case let .present(animated): present(screen, animated: animated, completion: completion)
        case let .push(animated):
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                completion()
            }
            pushViewController(screen, animated: animated)
            CATransaction.commit()
        case .crossDissolve:
            UIView.transition(
                with: view,
                duration: 0.75,
                options: .transitionCrossDissolve,
                animations: { [self] in
                    setViewControllers([screen], animated: false)
                }, completion: { _ in
                    completion()
                })
        }
    }
}
