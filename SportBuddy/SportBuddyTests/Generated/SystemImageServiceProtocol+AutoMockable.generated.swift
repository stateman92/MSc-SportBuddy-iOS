// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class SystemImageServiceProtocolMock: SystemImageServiceProtocol {

    //MARK: - image

    var imageSymbolCallsCount = 0
    var imageSymbolCalled: Bool {
        return imageSymbolCallsCount > 0
    }
    var imageSymbolReceivedSymbol: SFSymbol?
    var imageSymbolReceivedInvocations: [SFSymbol] = []
    var imageSymbolReturnValue: UIImage!
    var imageSymbolClosure: ((SFSymbol) -> UIImage)?

    func image(symbol: SFSymbol) -> UIImage {
        imageSymbolCallsCount += 1
        imageSymbolReceivedSymbol = symbol
        imageSymbolReceivedInvocations.append(symbol)
        return imageSymbolClosure.map({ $0(symbol) }) ?? imageSymbolReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
