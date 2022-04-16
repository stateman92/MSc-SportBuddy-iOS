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
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToLeading(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview = superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the trailing anchor to the superview's trailing anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToTrailing(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview = superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the bottom anchor to the superview's bottom anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToBottom(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview = superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the top anchor to the superview's top anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToTop(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview = superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
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
    /// - Parameters:
    ///   - top: the constant of the top constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - bottom: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - leading: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - trailing: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToSuperview(top: CGFloat? = nil,
                           bottom: CGFloat? = nil,
                           leading: CGFloat? = nil,
                           trailing: CGFloat? = nil,
                           safeArea: Bool = false) {
        anchorToSuperview(top: top,
                          topSafeArea: safeArea,
                          bottom: bottom,
                          bottomSafeArea: safeArea,
                          leading: leading,
                          leadingSafeArea: safeArea,
                          trailing: trailing,
                          trailingSafeArea: safeArea)
    }

    /// Constraint the view's anchors to the superview's anchors.
    /// - Parameters:
    ///   - top: the constant of the top constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - topSafeArea: whether to use the top safe area or not. By default `false`.
    ///   - bottom: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - bottomSafeArea: whether to use the bottom safe area or not. By default `false`.
    ///   - leading: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - leadingSafeArea: whether to use the leading safe area or not. By default `false`.
    ///   - trailing: the constant of the constraint. If `nil`, it will be ignored. By default `nil`.
    ///   - trailingSafeArea: whether to use the trailing safe area or not. By default `false`.
    func anchorToSuperview(top: CGFloat? = nil,
                           topSafeArea: Bool = false,
                           bottom: CGFloat? = nil,
                           bottomSafeArea: Bool = false,
                           leading: CGFloat? = nil,
                           leadingSafeArea: Bool = false,
                           trailing: CGFloat? = nil,
                           trailingSafeArea: Bool = false) {
        if let top = top {
            anchorToTop(constant: top, safeArea: topSafeArea)
        }
        if let bottom = bottom {
            anchorToBottom(constant: bottom, safeArea: bottomSafeArea)
        }
        if let leading = leading {
            anchorToLeading(constant: leading, safeArea: leadingSafeArea)
        }
        if let trailing = trailing {
            anchorToTrailing(constant: trailing, safeArea: trailingSafeArea)
        }
    }
}
