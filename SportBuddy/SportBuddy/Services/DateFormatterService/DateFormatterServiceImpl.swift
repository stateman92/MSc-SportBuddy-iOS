//
//  DateFormatterServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import Foundation

/// A class for handling the dates' formats in the app.
final class DateFormatterServiceImpl {
    // MARK: Properties

    private let dateFormatter = DateFormatter()
}

// MARK: - DateFormatterService

extension DateFormatterServiceImpl: DateFormatterService {
    /// Format the given date.
    /// - Parameters:
    ///   - date: the date to be formatted.
    func string(from date: Date, format: DateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }

    /// Create a date from the given string.
    /// - Parameters:
    ///   - string: the string.
    func date(from string: String) -> Date? {
        DateFormat.allCases.map(\.rawValue).compactMap(dateFormatter.date(from:)).first
    }
}
