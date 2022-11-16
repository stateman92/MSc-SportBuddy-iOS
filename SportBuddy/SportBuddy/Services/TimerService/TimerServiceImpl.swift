//
//  TimerServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 11. 16..
//

import Foundation

/// A class for managing timings.
final class TimerServiceImpl {
    // MARK: Properties

    private var timer: Timer?
}

// MARK: - TimerService

extension TimerServiceImpl: TimerService {
    func waitOnce(seconds: TimeInterval, completion: @escaping () -> Void) {
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: seconds, repeats: false) { _ in
            completion()
        }
    }
}
