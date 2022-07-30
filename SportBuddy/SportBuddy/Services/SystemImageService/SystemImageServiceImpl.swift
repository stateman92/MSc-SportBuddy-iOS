//
//  SystemImageServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import SFSafeSymbols
import UIKit

/// A class for managing system images.
final class SystemImageServiceImpl {

    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - SystemImageService

extension SystemImageServiceImpl: SystemImageService {
    /// Create an image based on a symbol.
    /// - Parameters:
    ///   - symbol: the symbol.
    /// - Returns:
    ///     The image.
    func image(symbol: SFSymbol) -> UIImage {
        UIImage(systemSymbol: symbol)
    }
}
