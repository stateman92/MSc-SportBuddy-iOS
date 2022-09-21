//
//  LiveFeedInputField.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import UIKit

final class LiveFeedInputField: BaseView {
    // MARK: Properties

    private let backgroundView = EffectView()
    private let textField = StyledTextView()
    private let button = ButtonLabel(text: L10n.Live.Feed.send, style: .tertiary, size: .normal)

    var sendText: (String) -> Void = { _ in } {
        didSet {
            button.tapped { [weak self] in
                self?.sendText(self?.textField.text ?? .init())
            }
        }
    }
}

// MARK: - Setups

extension LiveFeedInputField {
    override func setupView() {
        super.setupView()
        if !UIApplication.hasNotch {
            setupBackgroundView()
        }
        setupTextField()
        setupSendButton()
    }

    private func setupBackgroundView() {
        backgroundView.then {
            addSubview($0)
            $0.set(style: .systemThinMaterial)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero, safeArea: false)
        }
    }

    private func setupTextField() {
        textField.then {
            addSubview($0)
            $0.anchorToSuperview(top: 4, bottom: -4, leading: 16)
        }
    }

    private func setupSendButton() {
        button.then {
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            addSubview($0)
            $0.anchorToSuperview(trailing: -16)
            $0.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4).isActive = true
        }
    }
}
