//
//  VisualEffectView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class VisualEffectView: UIVisualEffectView {
    // MARK: Initialization

    override init(effect: UIVisualEffect? = nil) {
        super.init(effect: effect)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension VisualEffectView {
    private func setupView() {
        usingAutoLayout()
    }
}

// MARK: - Public methods

extension VisualEffectView {
    func set(style: UIBlurEffect.Style) {
        effect = UIBlurEffect(style: style)
    }
}
