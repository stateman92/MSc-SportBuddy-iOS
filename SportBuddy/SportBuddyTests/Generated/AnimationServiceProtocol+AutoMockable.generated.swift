// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import UIKit
@testable import SportBuddy

class AnimationServiceProtocolMock: AnimationServiceProtocol {

    //MARK: - load

    var loadJsonNameInCallsCount = 0
    var loadJsonNameInCalled: Bool {
        return loadJsonNameInCallsCount > 0
    }
    var loadJsonNameInReceivedArguments: (jsonName: String, view: View)?
    var loadJsonNameInReceivedInvocations: [(jsonName: String, view: View)] = []
    var loadJsonNameInClosure: ((String, View) -> Void)?

    func load(jsonName: String, in view: View) {
        loadJsonNameInCallsCount += 1
        loadJsonNameInReceivedArguments = (jsonName: jsonName, view: view)
        loadJsonNameInReceivedInvocations.append((jsonName: jsonName, view: view))
        loadJsonNameInClosure?(jsonName, view)
    }

    //MARK: - play

    var playInCallsCount = 0
    var playInCalled: Bool {
        return playInCallsCount > 0
    }
    var playInReceivedView: View?
    var playInReceivedInvocations: [View] = []
    var playInClosure: ((View) -> Void)?

    func play(in view: View) {
        playInCallsCount += 1
        playInReceivedView = view
        playInReceivedInvocations.append(view)
        playInClosure?(view)
    }

    //MARK: - pause

    var pauseInCallsCount = 0
    var pauseInCalled: Bool {
        return pauseInCallsCount > 0
    }
    var pauseInReceivedView: View?
    var pauseInReceivedInvocations: [View] = []
    var pauseInClosure: ((View) -> Void)?

    func pause(in view: View) {
        pauseInCallsCount += 1
        pauseInReceivedView = view
        pauseInReceivedInvocations.append(view)
        pauseInClosure?(view)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
