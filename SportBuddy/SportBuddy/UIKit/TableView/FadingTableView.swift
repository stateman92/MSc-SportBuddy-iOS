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
    private let outerColor = UIColor(white: 1, alpha: .zero)
    private let innerColor = UIColor(white: 1, alpha: 1)

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

        if contentOffset.y <= -contentInset.top {
            maskLayer.colors = [innerColor, innerColor, innerColor, outerColor].map(\.cgColor)
        } else if contentOffset.y + frame.size.height >= contentSize.height {
            maskLayer.colors = [outerColor, innerColor, innerColor, innerColor].map(\.cgColor)
        } else {
            maskLayer.colors = [outerColor, innerColor, innerColor, outerColor].map(\.cgColor)
        }

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
        let percent: CGFloat = 0.2

        maskLayer.locations = [.zero, percent, 1 - percent, 1].map { NSNumber(value: Double($0)) }
        maskLayer.anchorPoint = .zero
        layer.mask = maskLayer
    }
}
