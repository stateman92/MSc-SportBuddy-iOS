// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class SpeechServiceMock: SpeechService {

    //MARK: - read

    var readTextLanguageCallsCount = 0
    var readTextLanguageCalled: Bool {
        return readTextLanguageCallsCount > 0
    }
    var readTextLanguageReceivedArguments: (text: String, language: AVSpeechSynthesizer.Language)?
    var readTextLanguageReceivedInvocations: [(text: String, language: AVSpeechSynthesizer.Language)] = []
    var readTextLanguageClosure: ((String, AVSpeechSynthesizer.Language) -> Void)?

    func read(text: String, language: AVSpeechSynthesizer.Language) {
        readTextLanguageCallsCount += 1
        readTextLanguageReceivedArguments = (text: text, language: language)
        readTextLanguageReceivedInvocations.append((text: text, language: language))
        readTextLanguageClosure?(text, language)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
