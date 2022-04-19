// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class ImageLoadingServiceProtocolMock: ImageLoadingServiceProtocol {

    //MARK: - load

    var loadUrlInCallsCount = 0
    var loadUrlInCalled: Bool {
        return loadUrlInCallsCount > 0
    }
    var loadUrlInReceivedArguments: (url: URL, view: ImageView)?
    var loadUrlInReceivedInvocations: [(url: URL, view: ImageView)] = []
    var loadUrlInClosure: ((URL, ImageView) -> Void)?

    func load(url: URL, in view: ImageView) {
        loadUrlInCallsCount += 1
        loadUrlInReceivedArguments = (url: url, view: view)
        loadUrlInReceivedInvocations.append((url: url, view: view))
        loadUrlInClosure?(url, view)
    }

    //MARK: - cancelImageLoading

    var cancelImageLoadingInCallsCount = 0
    var cancelImageLoadingInCalled: Bool {
        return cancelImageLoadingInCallsCount > 0
    }
    var cancelImageLoadingInReceivedView: ImageView?
    var cancelImageLoadingInReceivedInvocations: [ImageView] = []
    var cancelImageLoadingInClosure: ((ImageView) -> Void)?

    func cancelImageLoading(in view: ImageView) {
        cancelImageLoadingInCallsCount += 1
        cancelImageLoadingInReceivedView = view
        cancelImageLoadingInReceivedInvocations.append(view)
        cancelImageLoadingInClosure?(view)
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
