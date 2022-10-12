//
//  FloatingPoint+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

extension FloatingPoint {
    func truncatingPositiveRemainder(dividingBy other: Self) -> Self {
        (self + other).truncatingRemainder(dividingBy: other)
    }
}
