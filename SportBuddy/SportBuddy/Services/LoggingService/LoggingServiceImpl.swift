//
//  LoggingServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 16..
//

import os

/// A class for managing the logging.
final class LoggingServiceImpl {
    // MARK: Properties

    private let logger: Logger

    // MARK: Initialization

    init(subsystem: String, category: String) {
        logger = Logger(subsystem: subsystem, category: category)
    }
}

// MARK: - LoggingService

extension LoggingServiceImpl: LoggingService {
    func log(_ logType: LogType, message: String) {
        switch logType {
        case let .default(privacy): `default`(message: message, privacy: privacy)
        case let .info(privacy): info(message: message, privacy: privacy)
        case let .debug(privacy): debug(message: message, privacy: privacy)
        case let .error(privacy): error(message: message, privacy: privacy)
        case let .fault(privacy): fault(message: message, privacy: privacy)
        case .critical: critical(message: message)
        }
        dump("Logged: type: \(logType), message: \(message)")
    }
}

// MARK: - Helpers

extension LoggingServiceImpl {
    private func `default`(message: String, privacy: LogPrivacy) {
        switch privacy {
        case .private: logger.log(level: .default, "\(message, privacy: .public)")
        case .public: logger.log(level: .default, "\(message, privacy: .private)")
        case .sensitive: logger.log(level: .default, "\(message, privacy: .sensitive)")
        case .auto: logger.log(level: .default, "\(message, privacy: .auto)")
        }
    }

    private func info(message: String, privacy: LogPrivacy) {
        switch privacy {
        case .private: logger.log(level: .info, "\(message, privacy: .public)")
        case .public: logger.log(level: .info, "\(message, privacy: .private)")
        case .sensitive: logger.log(level: .info, "\(message, privacy: .sensitive)")
        case .auto: logger.log(level: .info, "\(message, privacy: .auto)")
        }
    }

    private func debug(message: String, privacy: LogPrivacy) {
        switch privacy {
        case .private: logger.log(level: .debug, "\(message, privacy: .public)")
        case .public: logger.log(level: .debug, "\(message, privacy: .private)")
        case .sensitive: logger.log(level: .debug, "\(message, privacy: .sensitive)")
        case .auto: logger.log(level: .debug, "\(message, privacy: .auto)")
        }
    }

    private func error(message: String, privacy: LogPrivacy) {
        switch privacy {
        case .private: logger.log(level: .error, "\(message, privacy: .public)")
        case .public: logger.log(level: .error, "\(message, privacy: .private)")
        case .sensitive: logger.log(level: .error, "\(message, privacy: .sensitive)")
        case .auto: logger.log(level: .error, "\(message, privacy: .auto)")
        }
    }

    private func fault(message: String, privacy: LogPrivacy) {
        switch privacy {
        case .private: logger.log(level: .fault, "\(message, privacy: .public)")
        case .public: logger.log(level: .fault, "\(message, privacy: .private)")
        case .sensitive: logger.log(level: .fault, "\(message, privacy: .sensitive)")
        case .auto: logger.log(level: .fault, "\(message, privacy: .auto)")
        }
    }

    private func critical(message: String) {
        logger.critical("\(message)")
    }
}
