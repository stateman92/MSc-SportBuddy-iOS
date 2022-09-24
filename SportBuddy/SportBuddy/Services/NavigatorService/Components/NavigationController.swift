//
//  NavigationController.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 09..
//

import UIKit

final class NavigationController: UINavigationController {
    // MARK: Initialization

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.tintColor = .label
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NavigatorService

extension NavigationController: NavigatorService {
    /// Call to set the navigator as root in the given window.
    /// - Parameter window: the given window.
    func becameRoot(in window: UIWindow) {
        window.rootViewController = self
    }

    /// Presents a view controller.
    /// - Parameter screen: the view controller to display over the current view controller’s content.
    /// - Parameter type: the type of the animation.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    @discardableResult func present<T: UIViewController>(_ screen: T,
                                                         type: NavigationType,
                                                         completion: @escaping () -> Void) -> T {
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
        return screen
    }

    /// Pop some view controllers.
    /// - Parameter toViewController: until this view controller all view controllers will be popped. If `nil`, it pops the latest view controller.
    /// - Parameter animated: whether to use animation or not.
    func navigateBack(toViewController: UIViewController?, animated: Bool) {
        if let toViewController {
            popToViewController(toViewController, animated: animated)
        } else {
            popViewController(animated: animated)
        }
    }
}
