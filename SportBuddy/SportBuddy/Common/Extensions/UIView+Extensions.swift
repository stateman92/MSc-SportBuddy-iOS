//
//  UIView+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 31..
//

import UIKit

/// Very easy and convenient way to add `UITapGestureRecognizer` to `UIView` instances.
extension UIView {
    enum AssociatedObjectKeys {
        fileprivate static var tapGestureRecognizer = "tapGestureKey"
        fileprivate static var panGestureRecognizer = "panGestureRecognizer"
    }

    private var tapGestureRecognizerAction: ((_ tapGestureRecognizer: UITapGestureRecognizer) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue)
        }
    }

    /// Add a tap gesture recognizer to the view.
    /// - Parameters:
    ///   - numberOfTapsRequired: the number of taps required to match. By default `nil`.
    ///   - numberOfTouchesRequired: the number of fingers required to match. By default `nil`.
    ///   - action: the function that will be called.
    /// - Note:
    /// Just those porperties will be set that are not `nil`.
    /// - Returns:
    ///     The `UITapGestureRecognizer`.
    @discardableResult func addTapGestureRecognizer(
        numberOfTapsRequired: Int? = nil,
        numberOfTouchesRequired: Int? = nil,
        action: @escaping (_ tapGestureRecognizer: UITapGestureRecognizer
        ) -> Void) -> UITapGestureRecognizer {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))

        if let numberOfTapsRequired = numberOfTapsRequired {
            tapGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired
        }
        if let numberOfTouchesRequired = numberOfTouchesRequired {
            tapGestureRecognizer.numberOfTouchesRequired = numberOfTouchesRequired
        }

        addGestureRecognizer(tapGestureRecognizer)

        return tapGestureRecognizer
    }

    /// Add a tap gesture recognizer to the view.
    /// - Parameters:
    ///   - numberOfTapsRequired: the number of taps required to match. By default `nil`.
    ///   - numberOfTouchesRequired: the number of fingers required to match. By default `nil`.
    ///   - action: the function that will be called.
    /// - Note:
    /// Just those porperties will be set that are not `nil`.
    /// - Returns:
    ///     The `UITapGestureRecognizer`.
    @discardableResult func addTapGestureRecognizer(numberOfTapsRequired: Int? = nil,
                                                    numberOfTouchesRequired: Int? = nil,
                                                    action: @escaping () -> Void) -> UITapGestureRecognizer {
        addTapGestureRecognizer(numberOfTapsRequired: numberOfTapsRequired,
                                numberOfTouchesRequired: numberOfTouchesRequired) { _ in action() }
    }

    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        tapGestureRecognizerAction?(sender)
    }
}

extension UIView {
    private var panGestureRecognizerAction: ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void)? {
        get {
            getAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer)
        }
        set {
            setAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer, newValue)
        }
    }

    /// Add a pan gesture recognizer to the view.
    /// - Parameters:
    ///   - minimumNumberOfTouches: the minimum number of touches required to match. By default `nil`.
    ///   - maximumNumberOfTouches: the maximum number of touches that can be down. By default `nil`.
    ///   - action: the function that will be called.
    /// - Note:
    /// Just those porperties will be set that are not `nil`.
    /// - Returns:
    ///     The `UIPanGestureRecognizer`.
    @discardableResult public func addPanGestureRecognizer(
        minimumNumberOfTouches: Int? = nil,
        maximumNumberOfTouches: Int? = nil,
        action: @escaping (_ panGestureRecognizer: UIPanGestureRecognizer) -> Void
    ) -> UIPanGestureRecognizer {
        isUserInteractionEnabled = true
        panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))

        if let minimumNumberOfTouches = minimumNumberOfTouches {
            panGestureRecognizer.minimumNumberOfTouches = minimumNumberOfTouches
        }
        if let maximumNumberOfTouches = maximumNumberOfTouches {
            panGestureRecognizer.maximumNumberOfTouches = maximumNumberOfTouches
        }

        addGestureRecognizer(panGestureRecognizer)

        return panGestureRecognizer
    }

    /// Add a pan gesture recognizer to the view.
    /// - Parameters:
    ///   - minimumNumberOfTouches: the minimum number of touches required to match. By default `nil`.
    ///   - maximumNumberOfTouches: the maximum number of touches that can be down. By default `nil`.
    ///   - action: the function that will be called.
    /// - Note:
    /// Just those porperties will be set that are not `nil`.
    /// - Returns:
    ///     The `UIPanGestureRecognizer`.
    @discardableResult public func addPanGestureRecognizer(minimumNumberOfTouches: Int? = nil,
                                                           maximumNumberOfTouches: Int? = nil,
                                                           action: @escaping () -> Void) -> UIPanGestureRecognizer {
        addPanGestureRecognizer(minimumNumberOfTouches: minimumNumberOfTouches,
                                maximumNumberOfTouches: maximumNumberOfTouches,
                                action: { _ in action() })
    }

    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        panGestureRecognizerAction?(sender)
    }
}
