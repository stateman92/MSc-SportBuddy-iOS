//
//  SystemImageServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import SFSafeSymbols
import UIKit

/// A protocol for managing system images.
protocol SystemImageServiceProtocol: Initable, AutoMockable {
    /// Create an image based on a symbol.
    /// - Parameters:
    ///   - symbol: the symbol.
    /// - Returns:
    ///     The image.
    func image(symbol: SFSymbol) -> UIImage
}
