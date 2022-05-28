//
//  CopyService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 08..
//

import UIKit

/// A class for handling the copies in the app.
final class CopyService: Initable {
    // MARK: Properties

    private let pasteBoard: UIPasteboard = .general

    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - CopyServiceProtocol

extension CopyService: CopyServiceProtocol {
    /// Copy the given text.
    /// - Parameters:
    ///   - string: the text to be copied.
    func copy(string: String) {
        pasteBoard.string = string
    }

    /// Past the last element on the pasteboard.
    /// - Returns:
    ///     The last value of the pasteboard.
    func paste() -> String? {
        if pasteBoard.hasStrings {
            return pasteBoard.strings?.last
        }
        return nil
    }
}
