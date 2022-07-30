// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class LoadingServiceMock: LoadingService {
    var state: AnyPublisher<LoadingState, Never> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AnyPublisher<LoadingState, Never>!

    //MARK: - init

    var initStateTriggerSameValueReceivedArguments: (state: LoadingState, triggerSameValue: Bool)?
    var initStateTriggerSameValueReceivedInvocations: [(state: LoadingState, triggerSameValue: Bool)] = []
    var initStateTriggerSameValueClosure: ((LoadingState, Bool) -> Void)?

    required init(state: LoadingState, triggerSameValue: Bool) {
        initStateTriggerSameValueReceivedArguments = (state: state, triggerSameValue: triggerSameValue)
        initStateTriggerSameValueReceivedInvocations.append((state: state, triggerSameValue: triggerSameValue))
        initStateTriggerSameValueClosure?(state, triggerSameValue)
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

    //MARK: - loading

    var loadingBlockingDuringCallsCount = 0
    var loadingBlockingDuringCalled: Bool {
        return loadingBlockingDuringCallsCount > 0
    }
    var loadingBlockingDuringReceivedArguments: (blocking: Bool, closure: (@escaping () -> Void) -> Void)?
    var loadingBlockingDuringReceivedInvocations: [(blocking: Bool, closure: (@escaping () -> Void) -> Void)] = []
    var loadingBlockingDuringClosure: ((Bool, @escaping (@escaping () -> Void) -> Void) -> Void)?

    func loading(blocking: Bool, during closure: @escaping (@escaping () -> Void) -> Void) {
        loadingBlockingDuringCallsCount += 1
        loadingBlockingDuringReceivedArguments = (blocking: blocking, closure: closure)
        loadingBlockingDuringReceivedInvocations.append((blocking: blocking, closure: closure))
        loadingBlockingDuringClosure?(blocking, closure)
    }

    //MARK: - bind

    var bindToCallsCount = 0
    var bindToCalled: Bool {
        return bindToCallsCount > 0
    }
    var bindToReceivedService: LoadingOverlayService?
    var bindToReceivedInvocations: [LoadingOverlayService] = []
    var bindToClosure: ((LoadingOverlayService) -> Void)?

    func bind(to service: LoadingOverlayService) {
        bindToCallsCount += 1
        bindToReceivedService = service
        bindToReceivedInvocations.append(service)
        bindToClosure?(service)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
