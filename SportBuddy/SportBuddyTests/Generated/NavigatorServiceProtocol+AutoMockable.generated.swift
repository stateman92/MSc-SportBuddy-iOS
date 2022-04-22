// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import AVFoundation
import Combine
import UIKit
import SFSafeSymbols
@testable import SportBuddy

class NavigatorServiceProtocolMock: NavigatorServiceProtocol {
    var isNavigationBarHidden: Bool {
        get { return underlyingIsNavigationBarHidden }
        set(value) { underlyingIsNavigationBarHidden = value }
    }
    var underlyingIsNavigationBarHidden: Bool!
    var viewControllers: [UIViewController] = []

    //MARK: - init

    var initRootViewControllerReceivedRootViewController: UIViewController?
    var initRootViewControllerReceivedInvocations: [UIViewController] = []
    var initRootViewControllerClosure: ((UIViewController) -> Void)?

    required init(rootViewController: UIViewController) {
        initRootViewControllerReceivedRootViewController = rootViewController
        initRootViewControllerReceivedInvocations.append(rootViewController)
        initRootViewControllerClosure?(rootViewController)
    }
    //MARK: - becameRoot

    var becameRootInCallsCount = 0
    var becameRootInCalled: Bool {
        return becameRootInCallsCount > 0
    }
    var becameRootInReceivedWindow: UIWindow?
    var becameRootInReceivedInvocations: [UIWindow] = []
    var becameRootInClosure: ((UIWindow) -> Void)?

    func becameRoot(in window: UIWindow) {
        becameRootInCallsCount += 1
        becameRootInReceivedWindow = window
        becameRootInReceivedInvocations.append(window)
        becameRootInClosure?(window)
    }

    //MARK: - present

    var presentTypeCompletionCallsCount = 0
    var presentTypeCompletionCalled: Bool {
        return presentTypeCompletionCallsCount > 0
    }
    var presentTypeCompletionReceivedArguments: (screen: UIViewController, type: NavigationType, completion: () -> Void)?
    var presentTypeCompletionReceivedInvocations: [(screen: UIViewController, type: NavigationType, completion: () -> Void)] = []
    var presentTypeCompletionClosure: ((UIViewController, NavigationType, @escaping () -> Void) -> Void)?

    func present(_ screen: UIViewController, type: NavigationType, completion: @escaping () -> Void) {
        presentTypeCompletionCallsCount += 1
        presentTypeCompletionReceivedArguments = (screen: screen, type: type, completion: completion)
        presentTypeCompletionReceivedInvocations.append((screen: screen, type: type, completion: completion))
        presentTypeCompletionClosure?(screen, type, completion)
    }

}
