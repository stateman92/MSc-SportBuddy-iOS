//
//  DateFormatterService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Foundation

/// A protocol for handling the dates' formats in the app.
protocol DateFormatterService: Initable, AutoMockable {
    /// Format the given date.
    /// - Parameters:
    ///   - date: the date to be formatted.
    func string(from date: Date, format: DateFormat) -> String

    /// Create a date from the given string.
    /// - Parameters:
    ///   - string: the string.
    func date(from string: String) -> Date?
}

extension DateFormatterService {
    /// Format the given date.
    /// - Parameters:
    ///   - timestampe: the timestamp to be formatted.
    func string(from timestamp: Int, format: DateFormat) -> String {
        string(from: .init(secondsSince1970: timestamp), format: format)
    }
}
