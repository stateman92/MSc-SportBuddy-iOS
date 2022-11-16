//
//  TimerService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 11. 16..
//

import Foundation

/// A protocol for managing timings.
protocol TimerService {
    func waitOnce(seconds: TimeInterval, completion: @escaping () -> Void)
}
