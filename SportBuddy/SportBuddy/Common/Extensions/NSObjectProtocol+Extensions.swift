//
//  AnyObject+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import Foundation

extension NSObjectProtocol {
    /// A configure block like in Kotlin.
    /// - Parameters:
    ///   - block: the configuration block.
    /// - Returns:
    ///     The configured `Self`.
    @discardableResult func then(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
