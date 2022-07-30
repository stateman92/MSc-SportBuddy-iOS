// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class CopyServiceMock: CopyService {

    //MARK: - copy

    var copyStringCallsCount = 0
    var copyStringCalled: Bool {
        return copyStringCallsCount > 0
    }
    var copyStringReceivedString: String?
    var copyStringReceivedInvocations: [String] = []
    var copyStringClosure: ((String) -> Void)?

    func copy(string: String) {
        copyStringCallsCount += 1
        copyStringReceivedString = string
        copyStringReceivedInvocations.append(string)
        copyStringClosure?(string)
    }

    //MARK: - paste

    var pasteCallsCount = 0
    var pasteCalled: Bool {
        return pasteCallsCount > 0
    }
    var pasteReturnValue: String?
    var pasteClosure: (() -> String?)?

    func paste() -> String? {
        pasteCallsCount += 1
        return pasteClosure.map({ $0() }) ?? pasteReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
