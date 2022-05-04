//
//  ToastOverlayService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

/// A class for showing the toasts.
final class ToastOverlayService {
    // MARK: Constants

    private enum Constants {
        static let defaultVisibility: TimeInterval = 4
        static let slideUpDuration: TimeInterval = 0.5
        static let bottomConstraint: CGFloat = 24
    }

    // MARK: Properties

    private weak var parentView: UIView?
    private let message: String
    private let type: ToastType
    private var didRemove: () -> Void
    private var toast: Toast?

    // MARK: Initialization

    /// Initialize the service.
    /// - Parameters:
    ///   - on: the parent view.
    ///   - message: the message of the toast
    ///   - type: the type of the toast.
    ///   - didRemove: the closure that will be called if the toast did dismiss.
    init(on parentView: UIView,
         message: String,
         type: ToastType,
         didRemove: @escaping () -> Void = { }) {
        self.parentView = parentView
        self.message = message
        self.type = type
        self.didRemove = didRemove
    }
}

// MARK: - ToastOverlayServiceProtocol

extension ToastOverlayService: ToastOverlayServiceProtocol {
    /// Call to show the toast.
    func show() {
        guard let parentView = parentView else { return }

        toast = Toast(on: parentView,
                      message: message,
                      type: type,
                      dismiss: { [weak self] in self?.slideDown(resetToDefaultState: false) }).then {
            parentView.addSubview($0)
            $0.anchorToBottom(constant: -Constants.bottomConstraint, safeArea: true)
            $0.anchorToLeading(constant: 16)
            $0.anchorToTrailing(constant: -16)
        }

        setSlippedDownState(parentView: parentView)
        handleStates()
    }
}

// MARK: - Private methods

extension ToastOverlayService {
    private func handleStates() {
        slideUp(animateBorder: true) { [weak self] in
            guard let self = self, self.type.shouldDismissAutomatically else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.defaultVisibility) { [self] in
                let translation = self.toast?
                                    .gestureRecognizers?
                                    .compactMap { $0 as? UIPanGestureRecognizer }
                                    .first?
                                    .translation(in: self.toast)
                self.slideDown(resetToDefaultState: translation?.y.isNegative ?? true)
            }
        }
        var slippedDown = false
        toast?.addPanGestureRecognizer { [weak self] in
            guard !slippedDown else { return }
            self?.handle($0) {
                slippedDown = $0
            }
        }
    }

    private func handle(_ panGestureRecognizer: UIPanGestureRecognizer, didFinish: (Bool) -> Void) {
        let translationX = panGestureRecognizer.translation(in: toast).x
        let translationY = panGestureRecognizer.translation(in: toast).y
        switch panGestureRecognizer.state {
        case .changed:
            toast?.transform = .init(translationX: translationX / 5,
                                     y: translationY.isPositive ? translationY : translationY / 10)
        case .ended:
            let velocity = panGestureRecognizer.velocity(in: toast).y
            if velocity.isPositive, translationY.isPositive {
                didFinish(true)
                slideDown(resetToDefaultState: false, velocity: velocity)
            } else {
                slideUp()
            }
        default: break
        }
    }

    private func slideUp(animateBorder: Bool = false, completion: @escaping () -> Void = { }) {
        UIView.animate(
            withDuration: Constants.slideUpDuration,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.6,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { [self] in
                toast?.transform = .identity
                toast?.alpha = 1
                toast?.layer.borderColor = type.color.cgColor
            },
            completion: { [self] _ in
                completion()
                if animateBorder {
                    flashBorder()
                }
            })
    }

    private func flashBorder() {
        UIView.animate(
            withDuration: 2 * Constants.slideUpDuration,
            options: [.allowUserInteraction, .beginFromCurrentState, .curveEaseOut],
            animations: { [self] in
                toast?.layer.borderWidth = 4
            },
            completion: { [self] _ in
                guard !type.shouldRemainBordered else { return }
                UIView.animate(
                    withDuration: 2 * Constants.slideUpDuration,
                    delay: 2 * Constants.slideUpDuration,
                    options: [.allowUserInteraction, .beginFromCurrentState, .curveEaseIn],
                    animations: { [self] in toast?.layer.borderWidth = .zero })
            })
    }

    private func slideDown(resetToDefaultState: Bool, velocity: CGFloat? = nil) {
        guard let parentView = parentView else { return }
        toast?.gestureRecognizers?.forEach { toast?.removeGestureRecognizer($0) }
        let springVelocity = velocity ?? .zero / yTransformToSlippedDownState(parentView: parentView)
        UIView.animate(withDuration: resetToDefaultState ? 0.15 : .zero,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: { [self] in
            if resetToDefaultState {
                toast?.transform = .identity
            }
        }, completion: { _ in
            UIView.animate(withDuration: Constants.slideUpDuration,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: springVelocity / 40,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: { [self] in
                setSlippedDownState(parentView: parentView)
            }, completion: { [self] _ in
                toast?.removeFromSuperview()
                toast = nil
                didRemove()
                didRemove = { }
            })
        })
    }

    private func setSlippedDownState(parentView: UIView) {
        toast?.transform = CGAffineTransform(translationX: .zero,
                                             y: yTransformToSlippedDownState(parentView: parentView))
        toast?.alpha = .zero
    }

    private func yTransformToSlippedDownState(parentView: UIView) -> CGFloat {
        let height = toast?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? .zero
        return height + Constants.bottomConstraint + parentView.safeAreaInsets.bottom
    }
}
