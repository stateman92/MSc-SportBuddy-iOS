//
//  CircleImageView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 26..
//

import UIKit

final class CircleImageView: ImageView {
    // MARK: Initialization

    override init() {
        super.init()
        setup()
    }
}

// MARK: - Setups

extension CircleImageView {
    private func setup() {
        clipsToBounds = true
    }
}

// MARK: - Overridden methods

extension CircleImageView {
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = min(bounds.height, bounds.width) / 2
        }
    }
}
