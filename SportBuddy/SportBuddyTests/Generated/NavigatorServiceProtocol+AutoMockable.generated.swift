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

    var presentAnimatedCompletionCallsCount = 0
    var presentAnimatedCompletionCalled: Bool {
        return presentAnimatedCompletionCallsCount > 0
    }
    var presentAnimatedCompletionReceivedArguments: (viewControllerToPresent: UIViewController, flag: Bool, completion: (() -> Void)?)?
    var presentAnimatedCompletionReceivedInvocations: [(viewControllerToPresent: UIViewController, flag: Bool, completion: (() -> Void)?)] = []
    var presentAnimatedCompletionClosure: ((UIViewController, Bool, (() -> Void)?) -> Void)?

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentAnimatedCompletionCallsCount += 1
        presentAnimatedCompletionReceivedArguments = (viewControllerToPresent: viewControllerToPresent, flag: flag, completion: completion)
        presentAnimatedCompletionReceivedInvocations.append((viewControllerToPresent: viewControllerToPresent, flag: flag, completion: completion))
        presentAnimatedCompletionClosure?(viewControllerToPresent, flag, completion)
    }

}
