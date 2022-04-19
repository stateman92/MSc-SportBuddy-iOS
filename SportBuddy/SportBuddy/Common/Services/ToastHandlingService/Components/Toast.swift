//
//  Toast.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 19..
//

import UIKit

final class Toast: View {
    // MARK: Constants

    private enum Constant {
        static let defaultVisibility: TimeInterval = 4
        static let slideUpDuration: TimeInterval = 0.3
        static let bottomPadding: CGFloat = 24
    }

    // MARK: Properties

    private let message: String
    private let type: ToastType
    private let didRemove: () -> Void
    private weak var parentView: UIView?
    private var cancellables = Cancellables()
    private let imageView = ImageView()
    private let messageLabel = Label()
    private let closeButton = UIButton()
    private let contentColor: UIColor = .systemBackground.withAlphaComponent(0.9)
    @LazyInjected private var systemImageService: SystemImageServiceProtocol

    // MARK: Initialization

    init(view: UIView,
         message: String,
         type: ToastType,
         didRemove: @escaping () -> Void = { }) {
        self.message = message
        self.parentView = view
        self.type = type
        self.didRemove = didRemove
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension Toast {
    private func setupView() {
        alpha = .zero
        layer.zPosition = CGFloat(MAXFLOAT)
        layer.cornerRadius = 24
        backgroundColor = type.color.withAlphaComponent(0.5)

        setupImageView()
        setupMessageLabel()
        setupCloseImageView()
    }

    private func setupImageView() {
        imageView.then {
            addSubview($0)
            $0.anchorToCenterY()
            $0.tintColor = contentColor
            $0.anchorToLeading(constant: 16)
            $0.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16).isActive = true
            $0.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16).isActive = true
            $0.setWidth(40)
            $0.setHeight(40)
        }

        switch type {
        case .success: imageView.image = systemImageService.image(symbol: .checkmarkCircleFill)
        case .warning: imageView.image = systemImageService.image(symbol: .exclamationmarkCircleFill)
        case .error: imageView.image = systemImageService.image(symbol: .xCircleFill)
        }
    }

    private func setupMessageLabel() {
        messageLabel.then {
            addSubview($0)
            $0.text = message
            $0.anchorToBottom(constant: -16)
            $0.anchorToTop(constant: 16)
            $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
            $0.textAlignment = .left
            $0.numberOfLines = .zero
            $0.textColor = contentColor
        }
    }

    private func setupCloseImageView() {
        guard !type.shouldDismissAutomatically else {
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            return
        }

        closeButton.then {
            addSubview($0)
            $0.tintColor = contentColor
            $0.setImage(systemImageService.image(symbol: .xmark).withRenderingMode(.alwaysTemplate), for: .normal)
            $0.isUserInteractionEnabled = true
            $0.anchorToCenterY()
            $0.anchorToTrailing()
            $0.setWidth(44)
            $0.setHeight(44)
            $0.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor).isActive = true
            $0.addAction(.init { [weak self] _ in
                self?.slideDown()
            }, for: .touchUpInside)
        }
    }
}

// MARK: - Public methods

extension Toast {
    func show() {
        guard let parentView = parentView else { return }

        parentView.addSubview(self)

        anchorToBottom(constant: -Constant.bottomPadding, safeArea: true)
        anchorToLeading(constant: 16)
        anchorToTrailing(constant: -16)

            setSlippedDownState(parentView: parentView)
        handleStates()
    }
}

// MARK: - Private methods

extension Toast {
    private func handleStates() {
        slideUp { [weak self] _ in
            guard let self = self, self.type.shouldDismissAutomatically else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constant.defaultVisibility) {
                self.slideDown()
            }
        }
        var slippedDown = false
        addPanGestureRecognizer { [weak self] gestureRecognizer in
            guard let self = self, !slippedDown else { return }
            let translation = gestureRecognizer.translation(in: self)
            switch gestureRecognizer.state {
            case .changed:
                if translation.y.isPositive {
                    self.transform = .init(translationX: translation.x / 5, y: translation.y)
                } else {
                    self.transform = .init(translationX: translation.x / 5, y: translation.y / 10)
                }
                if translation.y > 75 {
                    slippedDown = true
                    self.slideDown()
                }
            case .ended:
                let velocity = gestureRecognizer.velocity(in: self).y
                if velocity > 2, translation.y.isPositive {
                    slippedDown = true
                    self.slideDown()
                } else {
                    self.slideUp()
                }
            default: break
            }
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
        transform = .identity
        alpha = 1
    }

    private func slideDown() {
        UIView.animate(withDuration: Constant.slideUpDuration,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: { [self] in
            guard let parentView = parentView else { return }
            setSlippedDownState(parentView: parentView)
        }, completion: { [self] _ in
            removeFromSuperview()
            didRemove()
        })
    }

    private func setSlippedDownState(parentView: UIView) {
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let yTransformationDistance = height + Constant.bottomPadding + parentView.safeAreaInsets.bottom
        transform = CGAffineTransform(translationX: 0, y: yTransformationDistance)
        alpha = 0
    }
}
