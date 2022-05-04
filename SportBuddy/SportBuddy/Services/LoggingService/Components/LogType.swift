//
//  LogType.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 16..
//

enum LogType {
    case `default`(LogPrivacy)
    case info(LogPrivacy)
    case debug(LogPrivacy)
    case error(LogPrivacy)
    case fault(LogPrivacy)
    case critical

    static var `default`: Self {
        .default(.auto)
    }

    static var info: Self {
        .info(.auto)
    }

    static var debug: Self {
        .debug(.auto)
    }

    static var error: Self {
        .error(.auto)
    }

    static var fault: Self {
        .fault(.auto)
    }
}
