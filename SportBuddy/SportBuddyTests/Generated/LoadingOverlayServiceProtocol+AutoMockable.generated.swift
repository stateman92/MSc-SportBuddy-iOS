// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Combine
import UIKit
@testable import SportBuddy

class LoadingOverlayServiceProtocolMock: LoadingOverlayServiceProtocol {

    //MARK: - init

    var initIsShowingReceivedIsShowing: Bool?
    var initIsShowingReceivedInvocations: [Bool] = []
    var initIsShowingClosure: ((Bool) -> Void)?

    required init(isShowing: Bool) {
        initIsShowingReceivedIsShowing = isShowing
        initIsShowingReceivedInvocations.append(isShowing)
        initIsShowingClosure?(isShowing)
    }
    //MARK: - set

    var setIsShowingCallsCount = 0
    var setIsShowingCalled: Bool {
        return setIsShowingCallsCount > 0
    }
    var setIsShowingReceivedIsShowing: Bool?
    var setIsShowingReceivedInvocations: [Bool] = []
    var setIsShowingClosure: ((Bool) -> Void)?

    func set(isShowing: Bool) {
        setIsShowingCallsCount += 1
        setIsShowingReceivedIsShowing = isShowing
        setIsShowingReceivedInvocations.append(isShowing)
        setIsShowingClosure?(isShowing)
    }

}
