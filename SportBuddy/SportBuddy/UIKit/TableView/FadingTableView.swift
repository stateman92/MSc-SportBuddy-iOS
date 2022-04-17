//
//  FadingTableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import UIKit

final class FadingTableView: TableView {
    // MARK: Properties

    private let maskLayer = CAGradientLayer()
    private let outerColor = UIColor(white: 1.0, alpha: 0.0)
    private let innerColor = UIColor(white: 1.0, alpha: 1.0)

    // MARK: Initialization

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
}

// MARK: - Overridden methods

extension FadingTableView {
    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        maskLayer.position = CGPoint(x: .zero, y: contentOffset.y)
        CATransaction.commit()
        maskLayer.bounds = CGRect(x: .zero, y: .zero, width: bounds.width, height: bounds.height)
    }
}

// MARK: - Setups

extension FadingTableView {
    private func setupView() {
        let percent: CGFloat = 0.5

        maskLayer.locations = [.zero, percent, 1 - percent, 1].map { NSNumber(value: Double($0)) }
        maskLayer.anchorPoint = .zero
        maskLayer.colors = [outerColor, innerColor, innerColor, outerColor].map(\.cgColor)
        layer.mask = maskLayer
    }
}
