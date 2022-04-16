//
//  AnimatedKeyboardObserver.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import Combine
import UIKit

/// A singleton class to deal with keyboard updates.
final class AnimatedKeyboardObserver {
    // MARK: Properties

    let beforeShowKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let showingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let afterShowingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let beforeHideKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let hidingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let afterHidingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    private let keyboardObserver = KeyboardObserver.shared
    private var cancellables = Cancellables()

    /// Singleton.
    static let shared = AnimatedKeyboardObserver()
    private init() {
        keyboardObserver.willShowNotification
            .sink { [unowned self] notification in
                guard let duration = notification.keyboardAnimationDuration,
                      let curve = notification.keyboardAnimationCurve?.asAnimationOptions,
                      let beginFrame = notification.keyboardFrameBegin,
                      let endFrame = notification.keyboardFrameEnd else {
                    return
                }

                UIView.animate(duration: duration,
                               timingFunction: .init(from: curve),
                               before: { beforeShowKeyboard.send((beginFrame, endFrame)) },
                               animations: { [self] in showingKeyboard.send((beginFrame, endFrame)) },
                               completion: { [self] _ in afterShowingKeyboard.send((beginFrame, endFrame)) })
            }
            .store(in: &cancellables)

        keyboardObserver.willHideNotification
            .sink { [unowned self] notification in
                guard let duration = notification.keyboardAnimationDuration,
                      let curve = notification.keyboardAnimationCurve?.asAnimationOptions,
                      let beginFrame = notification.keyboardFrameBegin,
                      let endFrame = notification.keyboardFrameEnd else {
                    return
                }

                UIView.animate(duration: duration,
                               timingFunction: .init(from: curve),
                               before: { beforeHideKeyboard.send((beginFrame, endFrame)) },
                               animations: { [self] in hidingKeyboard.send((beginFrame, endFrame)) },
                               completion: { [self] _ in afterHidingKeyboard.send((beginFrame, endFrame)) })
            }
            .store(in: &cancellables)
    }
}
