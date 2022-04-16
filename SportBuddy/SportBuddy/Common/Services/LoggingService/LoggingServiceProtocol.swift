//
//  LoggingServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 16..
//

import Foundation

/// A protocol for managing the logging.
protocol LoggingServiceProtocol: Initable {
    /// Initialize the service.
    /// - Parameters:
    ///   - subsystem: the subsystem.
    ///   - category: the category.
    init(subsystem: String, category: String)

    /// Log.
    /// - Parameters:
    ///   - logType: the type of the log.
    ///   - message: the message of the log.
    func log(_ logType: LogType, message: String)
}

extension LoggingServiceProtocol {
    /// Initialize the service. By default `subsystem` is `Bundle.main.bundleIdentifier ?? .init()` and `category` is `.init()`.
    init() {
        self.init(subsystem: Bundle.main.bundleIdentifier ?? .init(), category: .init())
    }

    /// Log.
    /// - Parameters:
    ///   - logType: the type of the log. By default `.debug`.
    ///   - message: the message of the log.
    func log(_ logType: LogType = .debug, message: String) {
        log(logType, message: message)
    }
}

extension LoggingServiceProtocol {
    /// Log with the default type.
    /// - Parameters:
    ///   - message: the message of the log.
    func `default`(message: String) {
        log(.default, message: message)
    }

    /// Log with the info type.
    /// - Parameters:
    ///   - message: the message of the log.
    func info(message: String) {
        log(.info, message: message)
    }

    /// Log with the debug type.
    /// - Parameters:
    ///   - message: the message of the log.
    func debug(message: String) {
        log(.debug, message: message)
    }

    /// Log with the error type.
    /// - Parameters:
    ///   - message: the message of the log.
    func error(message: String) {
        log(.error, message: message)
    }

    /// Log with the fault type.
    /// - Parameters:
    ///   - message: the message of the log.
    func fault(message: String) {
        log(.fault, message: message)
    }

    /// Log with the critical type.
    /// - Parameters:
    ///   - message: the message of the log.
    func critical(message: String) {
        log(.critical, message: message)
    }
}
