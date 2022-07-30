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
    }

    // MARK: Properties

    private weak var parentView: UIView?
    private let message: String
    private let type: ToastType
    private let dismiss: () -> Void

    private var cancellables = Cancellables()
    private let visualEffectView = EffectView()
    private let imageView = ImageView()
    private let messageLabel = Label()
    private let closeButton = UIButton()
    private let contentColor: UIColor = .label
    @LazyInjected private var systemImageService: SystemImageService

    // MARK: Initialization

    init(on parentView: UIView,
         message: String,
         type: ToastType,
         dismiss: @escaping () -> Void) {
        self.parentView = parentView
        self.message = message
        self.type = type
        self.dismiss = dismiss
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension Toast {
    private func setupView() {
        alpha = .zero
        clipsToBounds = true
        layer.masksToBounds = true
        layer.zPosition = CGFloat(MAXFLOAT)
        layer.cornerRadius = 24

        setupVisualEffectView()
        setupImageView()
        setupMessageLabel()
        setupCloseImageView()
    }

    private func setupVisualEffectView() {
        visualEffectView.then {
            addSubview($0)
            $0.set(tint: type.color, alpha: 0.5, blurRadius: 8)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
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
            $0.addAction(for: .touchUpInside) { [weak self] in self?.dismiss() }
        }
    }
}
