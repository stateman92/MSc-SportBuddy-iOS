//
//  StyledTextField.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 05..
//

import UIKit

final class StyledTextField: View {
    // MARK: Properties

    let textField = TextField()
    let placeholderLabel = Label()
    var placeholder: String {
        get {
            placeholderLabel.text ?? .init()
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    var placeholderBackgroundColor: UIColor {
        get {
            placeholderLabel.backgroundColor ?? .clear
        }
        set {
            placeholderLabel.backgroundColor = newValue
            contentView.backgroundColor = newValue
        }
    }
    var text: String {
        textField.text ?? .init()
    }
    private let contentView = View()

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension StyledTextField {
    private func setupView() {
        backgroundColor = Color.primary.color
        layer.cornerRadius = 16

        setupContentView()
        setupTextField()
        setupPlaceholderLabel()
    }

    private func setupContentView() {
        contentView.then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 14.5

            addSubview($0)
            $0.anchorToSuperview(top: 1.5, bottom: -1.5, leading: 1.5, trailing: -1.5)
        }
    }

    private func setupTextField() {
        textField.then {
            $0.tintColor = Color.primary.color
            $0.textColor = Color.primary.color
            $0.delegate = self

            contentView.addSubview($0)
            $0.anchorToSuperview(top: 8, bottom: -8, leading: 16, trailing: -16)
        }
    }

    private func setupPlaceholderLabel() {
        placeholderLabel.then {
            $0.backgroundColor = contentView.backgroundColor

            addSubview($0)
            $0.anchorToSuperview(top: 15, bottom: -15, leading: 20)
            $0.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -15).isActive = true

            $0.textColor = Color.primary.color
        }
    }
}

// MARK: - UITextFieldDelegate

extension StyledTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let desiredText = text.replacingCharacters(in: textRange, with: string)
            desiredText.isEmpty ? showPlaceholder() : hidePlaceholder()
        }
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showPlaceholder()
        return true
    }
}

// MARK: - Private methods

extension StyledTextField {
    private func showPlaceholder() {
        UIView.animate(withDuration: 0.33, delay: .zero, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.placeholderLabel.transform = .identity
        }
    }

    private func hidePlaceholder() {
        let scale = 0.66
        UIView.animate(withDuration: 0.33, delay: .zero, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.placeholderLabel.transform = .init(translationX: -self.placeholderLabel.bounds.width * (1 - scale) / 2,
                                                    y: -self.bounds.size.height / 2)
                .scaledBy(x: scale, y: scale)
        }
    }
}
