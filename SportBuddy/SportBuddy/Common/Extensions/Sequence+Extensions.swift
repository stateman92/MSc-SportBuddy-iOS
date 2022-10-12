//
//  Sequence+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

extension Sequence where Element: Equatable & Hashable {
    /// Get the unique elements in an `Array` of the `Sequence`.
    var uniqueArray: [Element] {
        Array(set)
    }

    /// Get a `Set` based on the `Sequence`.
    var set: Set<Element> {
        Set(self)
    }
}
