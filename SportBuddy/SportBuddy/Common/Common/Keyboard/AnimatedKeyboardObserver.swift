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
    /// Singleton.
    static let shared = AnimatedKeyboardObserver()

    private let keyboardObserver = KeyboardObserver.shared

    let beforeShowKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let showingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let afterShowingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let beforeHideKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let hidingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    let afterHidingKeyboard = PassthroughSubject<(CGRect, CGRect), Never>()
    private var cancellables = Set<AnyCancellable>()

    private init() {
        keyboardObserver.willShowNotification
            .sink { [unowned self] notification in
                guard let duration = notification.keyboardAnimationDuration,
                      let curve = notification.keyboardAnimationCurve?.asAnimationOptions,
                      let beginFrame = notification.keyboardFrameBegin,
                      let endFrame = notification.keyboardFrameEnd else {
                    return
                }

                UIView.animate(duration: duration, timingFunction: .init(from: curve)) {
                    beforeShowKeyboard.send((beginFrame, endFrame))
                } animations: {
                    showingKeyboard.send((beginFrame, endFrame))
                } completion: { _ in
                    afterShowingKeyboard.send((beginFrame, endFrame))
                }
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

                UIView.animate(duration: duration, timingFunction: .init(from: curve)) {
                    beforeHideKeyboard.send((beginFrame, endFrame))
                } animations: {
                    hidingKeyboard.send((beginFrame, endFrame))
                } completion: { _ in
                    afterHidingKeyboard.send((beginFrame, endFrame))
                }
            }
            .store(in: &cancellables)
    }
}