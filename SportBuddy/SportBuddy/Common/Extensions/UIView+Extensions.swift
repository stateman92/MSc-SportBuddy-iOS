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
    @discardableResult func addPanGestureRecognizer(
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
    @discardableResult func addPanGestureRecognizer(minimumNumberOfTouches: Int? = nil,
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

extension UIView {
    /// Call to prevent autoresizing mask's translation into constraints.
    func usingAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    /// Constraint the leading anchor to the superview's leading anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToLeading(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
    }

    /// Constraint the trailing anchor to the superview's trailing anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToTrailing(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
    }

    /// Constraint the bottom anchor to the superview's bottom anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToBottom(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
    }

    /// Constraint the top anchor to the superview's top anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToTop(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
    }

    /// Constraint the center y anchor to the superview's center y anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToCenterY(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }

    /// Constraint the center x anchor to the superview's center x anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToCenterX(constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        usingAutoLayout()
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }

    /// Set the height constraint of the view.
    /// - Parameter constant: the constant of the constraint.
    func setHeight(_ constant: CGFloat) {
        usingAutoLayout()
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    /// Set the height constraint of the view.
    /// - Parameter constant: the constant of the constraint.
    func setWidth(_ constant: CGFloat) {
        usingAutoLayout()
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    /// Set the size constraint of the view.
    /// - Parameter size: the size of the constraint.
    func setSize(_ size: CGSize) {
        setHeight(size.height)
        setWidth(size.width)
    }
}

extension UIView {
    /// Constraint the center x and y anchor to the superview's center x and y anchor.
    func anchorToCenter() {
        anchorToCenterX()
        anchorToCenterY()
    }

    /// Constraint the view's anchors to the superview's anchors.
    /// - Parameter top: the constant of the top constraint. If nil, it will be ignored. By default `nil`.
    /// - Parameter bottom: the constant of the constraint. If nil, it will be ignored. By default `nil`.
    /// - Parameter leading: the constant of the constraint. If nil, it will be ignored. By default `nil`.
    /// - Parameter trailing: the constant of the constraint. If nil, it will be ignored. By default `nil`.
    func anchorToSuperview(top: CGFloat? = nil,
                           bottom: CGFloat? = nil,
                           leading: CGFloat? = nil,
                           trailing: CGFloat? = nil) {
        if let top = top {
            anchorToTop(constant: top)
        }
        if let bottom = bottom {
            anchorToBottom(constant: bottom)
        }
        if let leading = leading {
            anchorToLeading(constant: leading)
        }
        if let trailing = trailing {
            anchorToTrailing(constant: trailing)
        }
    }
}
