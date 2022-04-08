//
//  Notification+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

extension Notification {
    /// The keyboard’s frame at the end of its animation.
    var keyboardFrameEnd: CGRect? {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }

    /// The keyboard’s frame at the beginning of its animation.
    var keyboardFrameBegin: CGRect? {
        (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
    }

    /// Whether the keyboard belongs to the current app.
    var keyboardBelongsToCurrentApp: Bool? {
        (userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue
    }

    /// The time interval of the keyboard animation (in seconds).
    var keyboardAnimationDuration: TimeInterval? {
        (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }

    /// The animation curve that the system uses to animate the keyboard onto or off the screen.
    var keyboardAnimationCurve: UIView.AnimationCurve? {
        guard let rawValue = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue else {
            return nil
        }
        return UIView.AnimationCurve(rawValue: rawValue)
    }
}
