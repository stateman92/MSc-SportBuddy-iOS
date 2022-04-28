//
//  UIViewController+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 05..
//

import UIKit

extension UIViewController {
    /// Hide the keyboard after the user taps somewhere else on the screen.
    /// - Note:
    /// To end the functionality, just call `.removeFromView()` on the returned value of this function.
    /// - Returns:
    ///     The gesture recognizer.
    @discardableResult func hideKeyboardWhenTappedOutside() -> UITapGestureRecognizer {
        guard !(self is UITabBarController) else {
            let warning = "The function hideKeyboardWhenTappedOutside() shouldn't be called from a UITabBarController!"
            preconditionFailure(warning)
        }
        return view
            .addTapGestureRecognizer { [weak self] in
                self?.view.endEditing(true)
            }
            .then {
                $0.cancelsTouchesInView = false
            }
    }
}
