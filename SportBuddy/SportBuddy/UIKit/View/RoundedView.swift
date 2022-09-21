//
//  RoundedView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

final class RoundedView: View {
    // MARK: Nested types

    enum Roundness {
        case constant(CGFloat)
        case multiplier(CGFloat)

        fileprivate func radius(minDimension: CGFloat) -> CGFloat {
            switch self {
            case let .constant(constant): return constant > minDimension / 2 ? minDimension / 2 : constant
            case let .multiplier(multiplier): return minDimension / 2 * multiplier
            }
        }
    }

    // MARK: Properties

    var multiplier: Roundness = .multiplier(1) {
        didSet {
            refreshCorners()
        }
    }
}

// MARK: - Overridden methods

extension RoundedView {
    override var bounds: CGRect {
        didSet {
            refreshCorners()
        }
    }
}

// MARK: - Private methods

extension RoundedView {
    private func refreshCorners() {
        layer.cornerRadius = multiplier.radius(minDimension: min(bounds.height, bounds.width))
    }
}
