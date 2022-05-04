//
//  StyledTextView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

final class StyledTextView: View {
    // MARK: Properties

    private let textView = ScrollingTextView()
    private let contentView = View()
    var text: String {
        textView.text
    }

    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Setups

extension StyledTextView {
    private func setupView() {
        backgroundColor = Color.primary.color
        layer.cornerRadius = 16

        setupContentView()
        setupTextView()
    }

    private func setupContentView() {
        contentView.then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 14.5

            addSubview($0)
            $0.anchorToSuperview(top: 1.5, bottom: -1.5, leading: 1.5, trailing: -1.5)
        }
    }

    private func setupTextView() {
        textView.then {
            $0.tintColor = Color.primary.color
            $0.textColor = Color.primary.color

            contentView.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: 4, trailing: -4)
        }
    }
}
