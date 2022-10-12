//
//  Collection+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 12..
//

import Foundation

extension Collection {
    /// Return the element at the specified index if it is within its bounds, otherwise `nil`.
    /// - Parameters:
    ///   - safe: the index of the element.
    /// - Returns:
    ///     The element at the index.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
