// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class ToastOverlayServiceMock: ToastOverlayService {

    //MARK: - init

    var initOnMessageTypeDidRemoveReceivedArguments: (view: UIView, message: String, type: ToastType, didRemove: () -> Void)?
    var initOnMessageTypeDidRemoveReceivedInvocations: [(view: UIView, message: String, type: ToastType, didRemove: () -> Void)] = []
    var initOnMessageTypeDidRemoveClosure: ((UIView, String, ToastType, @escaping () -> Void) -> Void)?

    required init(on view: UIView, message: String, type: ToastType, didRemove: @escaping () -> Void) {
        initOnMessageTypeDidRemoveReceivedArguments = (view: view, message: message, type: type, didRemove: didRemove)
        initOnMessageTypeDidRemoveReceivedInvocations.append((view: view, message: message, type: type, didRemove: didRemove))
        initOnMessageTypeDidRemoveClosure?(view, message, type, didRemove)
    }
    //MARK: - show

    var showCallsCount = 0
    var showCalled: Bool {
        return showCallsCount > 0
    }
    var showClosure: (() -> Void)?

    func show() {
        showCallsCount += 1
        showClosure?()
    }

}
