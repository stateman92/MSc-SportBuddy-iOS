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

    private enum Constant {
        static let defaultVisibility: TimeInterval = 4
        static let slideUpDuration: TimeInterval = 0.3
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
            $0.anchorToBottom(constant: -24, safeArea: true)
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
        slideUp { [weak self] _ in
            guard let self = self, self.type.shouldDismissAutomatically else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constant.defaultVisibility) {
                self.slideDown(resetToDefaultState: true)
            }
        }
        var slippedDown = false
        toast?.addPanGestureRecognizer { [weak self] in
            guard !slippedDown else { return }
            self?.handle($0, madeFinish: &slippedDown)
        }
    }

    private func handle(_ panGestureRecognizer: UIPanGestureRecognizer, madeFinish: inout Bool) {
        let translationX = panGestureRecognizer.translation(in: toast).x
        let translationY = panGestureRecognizer.translation(in: toast).y
        switch panGestureRecognizer.state {
        case .changed:
            toast?.transform = .init(translationX: translationX / 5,
                                     y: translationY.isPositive ? translationY : translationY / 10)
            if translationY > 75 {
                madeFinish = true
                slideDown(resetToDefaultState: false)
            }
        case .ended:
            let velocity = panGestureRecognizer.velocity(in: toast).y
            if velocity > 2, translationY.isPositive {
                madeFinish = true
                slideDown(resetToDefaultState: false)
            } else {
                slideUp()
            }
        default: break
        }
    }

    private func slideUp(completion: @escaping (Bool) -> Void = { _ in }) {
        UIView.animate(withDuration: Constant.slideUpDuration,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: { [self] in
            setDefaultState()
        }, completion: completion)
    }

    private func setDefaultState() {
        toast?.transform = .identity
        toast?.alpha = 1
    }

    private func slideDown(resetToDefaultState: Bool) {
        toast?.gestureRecognizers?.forEach { toast?.removeGestureRecognizer($0) }
        UIView.animate(withDuration: resetToDefaultState ? 0.15 : .zero,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: { [self] in
            if resetToDefaultState {
                toast?.transform = .identity
            }
        }, completion: { _ in
            UIView.animate(withDuration: Constant.slideUpDuration,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: { [self] in
                guard let parentView = parentView else { return }
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
        let height = toast?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? .zero
        let yTransformationDistance = height + 24 + parentView.safeAreaInsets.bottom
        toast?.transform = CGAffineTransform(translationX: .zero, y: yTransformationDistance)
        toast?.alpha = .zero
    }
}
