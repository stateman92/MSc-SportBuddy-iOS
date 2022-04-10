//
//  StackView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 26..
//

import UIKit

final class StackView: UIStackView {
    // MARK: Initialization

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension StackView {
    private func setupView() {
        usingAutoLayout()
    }
}
