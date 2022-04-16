// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class LoadingServiceProtocolMock: LoadingServiceProtocol {
    var state: AnyPublisher<Bool, Never> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AnyPublisher<Bool, Never>!

    //MARK: - init

    var initIsShowingTriggerSameValueReceivedArguments: (isShowing: Bool, triggerSameValue: Bool)?
    var initIsShowingTriggerSameValueReceivedInvocations: [(isShowing: Bool, triggerSameValue: Bool)] = []
    var initIsShowingTriggerSameValueClosure: ((Bool, Bool) -> Void)?

    required init(isShowing: Bool, triggerSameValue: Bool) {
        initIsShowingTriggerSameValueReceivedArguments = (isShowing: isShowing, triggerSameValue: triggerSameValue)
        initIsShowingTriggerSameValueReceivedInvocations.append((isShowing: isShowing, triggerSameValue: triggerSameValue))
        initIsShowingTriggerSameValueClosure?(isShowing, triggerSameValue)
    }
    //MARK: - setState

    var setStateIsShowingCallsCount = 0
    var setStateIsShowingCalled: Bool {
        return setStateIsShowingCallsCount > 0
    }
    var setStateIsShowingReceivedShowing: Bool?
    var setStateIsShowingReceivedInvocations: [Bool] = []
    var setStateIsShowingClosure: ((Bool) -> Void)?

    func setState(isShowing showing: Bool) {
        setStateIsShowingCallsCount += 1
        setStateIsShowingReceivedShowing = showing
        setStateIsShowingReceivedInvocations.append(showing)
        setStateIsShowingClosure?(showing)
    }

    //MARK: - loading

    var loadingDuringCallsCount = 0
    var loadingDuringCalled: Bool {
        return loadingDuringCallsCount > 0
    }
    var loadingDuringReceivedClosure: ((@escaping () -> Void) -> Void)?
    var loadingDuringReceivedInvocations: [((@escaping () -> Void) -> Void)] = []
    var loadingDuringClosure: ((@escaping (@escaping () -> Void) -> Void) -> Void)?

    func loading(during closure: @escaping (@escaping () -> Void) -> Void) {
        loadingDuringCallsCount += 1
        loadingDuringReceivedClosure = closure
        loadingDuringReceivedInvocations.append(closure)
        loadingDuringClosure?(closure)
    }

    //MARK: - bind

    var bindToCallsCount = 0
    var bindToCalled: Bool {
        return bindToCallsCount > 0
    }
    var bindToReceivedService: LoadingOverlayServiceProtocol?
    var bindToReceivedInvocations: [LoadingOverlayServiceProtocol] = []
    var bindToClosure: ((LoadingOverlayServiceProtocol) -> Void)?

    func bind(to service: LoadingOverlayServiceProtocol) {
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
