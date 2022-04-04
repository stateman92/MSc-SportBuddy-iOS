//
//  Navigator.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// Navigation protocol for in-app navigation.
protocol Navigator: AnyObject, AutoMockable {
    /// Presents a view controller modally.
    /// - Parameter viewControllerToPresent: the view controller to display over the current view controller’s content.
    /// - Parameter animated: `true` if you want to animate the presentation, otherwise `false`.
    /// - Parameter completion: the completion block to execute after the presentation finished.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension Navigator {
    /// Presents a view controller modally.
    /// - Parameter viewControllerToPresent: the view controller to display over the current view controller’s content.
    /// - Parameter animated: `true` if you want to animate the presentation, otherwise `false`.
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: flag, completion: nil)
    }
}

extension UINavigationController: Navigator { }
