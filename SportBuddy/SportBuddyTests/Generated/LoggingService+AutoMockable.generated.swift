// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class LoggingServiceMock: LoggingService {

    //MARK: - init

    var initSubsystemCategoryReceivedArguments: (subsystem: String, category: String)?
    var initSubsystemCategoryReceivedInvocations: [(subsystem: String, category: String)] = []
    var initSubsystemCategoryClosure: ((String, String) -> Void)?

    required init(subsystem: String, category: String) {
        initSubsystemCategoryReceivedArguments = (subsystem: subsystem, category: category)
        initSubsystemCategoryReceivedInvocations.append((subsystem: subsystem, category: category))
        initSubsystemCategoryClosure?(subsystem, category)
    }
    //MARK: - log

    var logMessageCallsCount = 0
    var logMessageCalled: Bool {
        return logMessageCallsCount > 0
    }
    var logMessageReceivedArguments: (logType: LogType, message: String)?
    var logMessageReceivedInvocations: [(logType: LogType, message: String)] = []
    var logMessageClosure: ((LogType, String) -> Void)?

    func log(_ logType: LogType, message: String) {
        logMessageCallsCount += 1
        logMessageReceivedArguments = (logType: logType, message: message)
        logMessageReceivedInvocations.append((logType: logType, message: message))
        logMessageClosure?(logType, message)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
