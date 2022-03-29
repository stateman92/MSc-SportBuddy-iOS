//
//  VisualEffectView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class VisualEffectView: UIVisualEffectView {
    override init(effect: UIVisualEffect? = nil) {
        super.init(effect: effect)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VisualEffectView {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        effect = UIBlurEffect(style: .dark)
    }
}

extension VisualEffectView {
    func set(style: UIBlurEffect.Style) {
        effect = UIBlurEffect(style: style)
    }
}
