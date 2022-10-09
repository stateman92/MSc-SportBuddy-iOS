// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class ToastServiceMock: ToastService {

    //MARK: - init

    var initOnOverlayServiceTypeReceivedArguments: (view: UIView?, overlayServiceType: ToastOverlayService.Type)?
    var initOnOverlayServiceTypeReceivedInvocations: [(view: UIView?, overlayServiceType: ToastOverlayService.Type)] = []
    var initOnOverlayServiceTypeClosure: ((UIView?, ToastOverlayService.Type) -> Void)?

    required init(on view: UIView?, overlayServiceType: ToastOverlayService.Type) {
        initOnOverlayServiceTypeReceivedArguments = (view: view, overlayServiceType: overlayServiceType)
        initOnOverlayServiceTypeReceivedInvocations.append((view: view, overlayServiceType: overlayServiceType))
        initOnOverlayServiceTypeClosure?(view, overlayServiceType)
    }
    //MARK: - showToast

    var showToastWithCallsCount = 0
    var showToastWithCalled: Bool {
        return showToastWithCallsCount > 0
    }
    var showToastWithReceivedItem: ToastItem?
    var showToastWithReceivedInvocations: [ToastItem] = []
    var showToastWithClosure: ((ToastItem) -> Void)?

    func showToast(with item: ToastItem) {
        showToastWithCallsCount += 1
        showToastWithReceivedItem = item
        showToastWithReceivedInvocations.append(item)
        showToastWithClosure?(item)
    }

    //MARK: - invalidateQueue

    var invalidateQueueCallsCount = 0
    var invalidateQueueCalled: Bool {
        return invalidateQueueCallsCount > 0
    }
    var invalidateQueueClosure: (() -> Void)?

    func invalidateQueue() {
        invalidateQueueCallsCount += 1
        invalidateQueueClosure?()
    }

}
