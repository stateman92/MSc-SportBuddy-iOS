//
//  ToastType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

enum ToastType {
    case success
    case warning
    case error

    var shouldDismissAutomatically: Bool {
        if case .error = self {
            return false
        }
        return true
    }

    var color: UIColor {
        switch self {
        case .success: return .systemGreen
        case .warning: return .systemOrange
        case .error: return .systemRed
        }
    }

    var shouldRemainBordered: Bool {
        if case .error = self {
            return true
        }
        return false
    }
}
