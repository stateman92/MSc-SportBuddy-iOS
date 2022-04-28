// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class LoadingOverlayServiceProtocolMock: LoadingOverlayServiceProtocol {

    //MARK: - init

    var initStateReceivedState: LoadingState?
    var initStateReceivedInvocations: [LoadingState] = []
    var initStateClosure: ((LoadingState) -> Void)?

    required init(state: LoadingState) {
        initStateReceivedState = state
        initStateReceivedInvocations.append(state)
        initStateClosure?(state)
    }
    //MARK: - set

    var setStateCallsCount = 0
    var setStateCalled: Bool {
        return setStateCallsCount > 0
    }
    var setStateReceivedState: LoadingState?
    var setStateReceivedInvocations: [LoadingState] = []
    var setStateClosure: ((LoadingState) -> Void)?

    func set(state: LoadingState) {
        setStateCallsCount += 1
        setStateReceivedState = state
        setStateReceivedInvocations.append(state)
        setStateClosure?(state)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
