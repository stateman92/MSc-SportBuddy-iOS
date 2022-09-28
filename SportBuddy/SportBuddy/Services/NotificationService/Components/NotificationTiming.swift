//
//  NotificationModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 26..
//

import Foundation

enum NotificationTiming {
    case now
    case after(TimeInterval)

    var timeInterval: TimeInterval {
        switch self {
        case .now: return 0.01
        case let .after(timeInterval): return timeInterval
        }
    }
}
