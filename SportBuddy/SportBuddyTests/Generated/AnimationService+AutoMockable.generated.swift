// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class AnimationServiceMock: AnimationService {

    //MARK: - load

    var loadAnimationInCallsCount = 0
    var loadAnimationInCalled: Bool {
        return loadAnimationInCallsCount > 0
    }
    var loadAnimationInReceivedArguments: (animation: Animations, view: View)?
    var loadAnimationInReceivedInvocations: [(animation: Animations, view: View)] = []
    var loadAnimationInClosure: ((Animations, View) -> Void)?

    func load(animation: Animations, in view: View) {
        loadAnimationInCallsCount += 1
        loadAnimationInReceivedArguments = (animation: animation, view: view)
        loadAnimationInReceivedInvocations.append((animation: animation, view: view))
        loadAnimationInClosure?(animation, view)
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
