// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class TranslatorServiceMock: TranslatorService {

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - translation

    var translationOfCallsCount = 0
    var translationOfCalled: Bool {
        return translationOfCallsCount > 0
    }
    var translationOfReceivedKey: String?
    var translationOfReceivedInvocations: [String] = []
    var translationOfReturnValue: String!
    var translationOfClosure: ((String) -> String)?

    func translation(of key: String) -> String {
        translationOfCallsCount += 1
        translationOfReceivedKey = key
        translationOfReceivedInvocations.append(key)
        return translationOfClosure.map({ $0(key) }) ?? translationOfReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
