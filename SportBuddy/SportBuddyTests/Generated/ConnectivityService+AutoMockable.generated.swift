// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class ConnectivityServiceMock: ConnectivityService {
    var isNetworkReachable: AnyPublisher<Bool, Never> {
        get { return underlyingIsNetworkReachable }
        set(value) { underlyingIsNetworkReachable = value }
    }
    var underlyingIsNetworkReachable: AnyPublisher<Bool, Never>!

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
