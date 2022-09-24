//
//  UIView+Constraints.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

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
        guard let superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the trailing anchor to the superview's trailing anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToTrailing(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the bottom anchor to the superview's bottom anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToBottom(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the top anchor to the superview's top anchor.
    /// - Parameters:
    ///   - constant: the constant of the constraint. By default `.zero`.
    ///   - safeArea: whether to use the safe area or not. By default `false`.
    func anchorToTop(constant: CGFloat = .zero, safeArea: Bool = false) {
        guard let superview else { return }
        usingAutoLayout()
        let anchor = safeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    /// Constraint the center y anchor to the superview's center y anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToCenterY(constant: CGFloat = .zero) {
        guard let superview else { return }
        usingAutoLayout()
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }

    /// Constraint the center x anchor to the superview's center x anchor.
    /// - Parameter constant: the constant of the constraint. By default `.zero`.
    func anchorToCenterX(constant: CGFloat = .zero) {
        guard let superview else { return }
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
        if let top {
            anchorToTop(constant: top, safeArea: topSafeArea)
        }
        if let bottom {
            anchorToBottom(constant: bottom, safeArea: bottomSafeArea)
        }
        if let leading {
            anchorToLeading(constant: leading, safeArea: leadingSafeArea)
        }
        if let trailing {
            anchorToTrailing(constant: trailing, safeArea: trailingSafeArea)
        }
    }
}
