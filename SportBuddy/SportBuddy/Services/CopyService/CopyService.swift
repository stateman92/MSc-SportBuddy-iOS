//
//  CopyService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 08..
//

/// A protocol for handling the copies in the app.
protocol CopyService: Initable, AutoMockable {
    /// Copy the given text.
    /// - Parameters:
    ///   - string: the text to be copied.
    func copy(string: String)

    /// Past the last element on the pasteboard.
    /// - Returns:
    ///     The last value of the pasteboard.
    func paste() -> String?
}
