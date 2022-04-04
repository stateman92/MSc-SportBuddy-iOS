//
//  UIApplication+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

extension UIApplication {
    /// The key window (if exists).
    var keyWindow: UIWindow? {
        windows.first { $0.isKeyWindow }
    }

    /// Set the default network indicator on the status bar.
    /// - Parameter isVisible: whether the indicator is visible.
    /// - Note: Deprecated in iOS 13, but on phones without notch it works. Use it only in addition to another sign.
    func setNetworkIndicator(isVisible: Bool) {
        isNetworkActivityIndicatorVisible = isVisible
    }
}
