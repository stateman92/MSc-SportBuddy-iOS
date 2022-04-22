//
//  VisualEffectView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit
import VisualEffectView

final class EffectView: VisualEffectView {
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

extension EffectView {
    private func setupView() {
        usingAutoLayout()
    }
}

// MARK: - Public methods

extension EffectView {
    func set(style: UIBlurEffect.Style?) {
        if let style = style {
            effect = UIBlurEffect(style: style)
        } else {
            effect = nil
        }
    }

    func set(tint: UIColor, alpha: CGFloat, blurRadius: CGFloat) {
        colorTint = tint
        colorTintAlpha = alpha
        self.blurRadius = blurRadius
    }
}
