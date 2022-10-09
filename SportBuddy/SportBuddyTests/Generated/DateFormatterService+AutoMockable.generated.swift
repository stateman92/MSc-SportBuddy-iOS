// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class DateFormatterServiceMock: DateFormatterService {

    //MARK: - string

    var stringFromFormatCallsCount = 0
    var stringFromFormatCalled: Bool {
        return stringFromFormatCallsCount > 0
    }
    var stringFromFormatReceivedArguments: (date: Date, format: DateFormat)?
    var stringFromFormatReceivedInvocations: [(date: Date, format: DateFormat)] = []
    var stringFromFormatReturnValue: String!
    var stringFromFormatClosure: ((Date, DateFormat) -> String)?

    func string(from date: Date, format: DateFormat) -> String {
        stringFromFormatCallsCount += 1
        stringFromFormatReceivedArguments = (date: date, format: format)
        stringFromFormatReceivedInvocations.append((date: date, format: format))
        return stringFromFormatClosure.map({ $0(date, format) }) ?? stringFromFormatReturnValue
    }

    //MARK: - date

    var dateFromCallsCount = 0
    var dateFromCalled: Bool {
        return dateFromCallsCount > 0
    }
    var dateFromReceivedString: String?
    var dateFromReceivedInvocations: [String] = []
    var dateFromReturnValue: Date?
    var dateFromClosure: ((String) -> Date?)?

    func date(from string: String) -> Date? {
        dateFromCallsCount += 1
        dateFromReceivedString = string
        dateFromReceivedInvocations.append(string)
        return dateFromClosure.map({ $0(string) }) ?? dateFromReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
