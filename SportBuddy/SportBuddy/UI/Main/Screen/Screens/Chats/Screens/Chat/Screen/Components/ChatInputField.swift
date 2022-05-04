//
//  ChatInputField.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

final class ChatInputField: View {
    // MARK: Properties

    private let backgroundView = View()
    private let textField = StyledTextView()
    private let button = ButtonLabel(text: "Send", style: .tertiary, size: .small)

    var sendText: (String) -> Void = { _ in } {
        didSet {
            button.tapped { [weak self] in
                self?.sendText(self?.textField.text ?? .init())
            }
        }
    }

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension ChatInputField {
    private func setupView() {
        setupBackgroundView()
        setupTextField()
        setupSendButton()
    }

    private func setupBackgroundView() {
        backgroundView.then {
            addSubview($0)
            $0.anchorToSuperview(top: .zero, leading: .zero, trailing: .zero, safeArea: false)
            $0.backgroundColor = .white
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        }
    }

    private func setupTextField() {
        textField.then {
            addSubview($0)
            $0.anchorToSuperview(top: 4, bottom: -4, leading: 4)
        }
    }

    private func setupSendButton() {
        button.then {
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            addSubview($0)
            $0.anchorToSuperview(trailing: -4)
            $0.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4).isActive = true
        }
    }
}
