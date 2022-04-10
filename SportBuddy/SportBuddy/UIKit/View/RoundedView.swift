//
//  RoundedView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class RoundedView: View {
    // MARK: Properties

    var multiplier: CGFloat = 1
}

// MARK: - Overridden methods

extension RoundedView {
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height / 2 * multiplier
        }
    }
}
