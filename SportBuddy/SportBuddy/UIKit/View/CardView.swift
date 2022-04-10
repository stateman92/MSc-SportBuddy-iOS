//
//  cardView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 07..
//

import UIKit

final class CardView: View {
    // MARK: Initialization

    override init() {
        super.init()
        setupView()
    }
}

// MARK: - Overridden methods

extension CardView {
    override var bounds: CGRect {
        didSet {
            let min = min(bounds.height, bounds.width)
            if min < 50 {
                layer.cornerRadius = min / 2
            } else {
                layer.cornerRadius = 25
            }
        }
    }
}

// MARK: - Setups

extension CardView {
    private func setupView() {
        backgroundColor = .white
    }
}

// MARK: - Public methods

extension CardView {
    func add(view: UIView, padding: CGFloat) {
        view.then {
            addSubview($0)
            $0.anchorToSuperview(top: padding, bottom: -padding, leading: padding, trailing: -padding)
        }
    }
}
