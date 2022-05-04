//
//  ReversedTableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 24..
//

import UIKit

class ReversedTableView: TableView {
    // MARK: Initialization

    init(style: Style) {
        super.init(frame: .zero, style: style)
        setupView()
    }
}

// MARK: - Setups

extension ReversedTableView {
    private func setupView() {
        transform = .init(rotationAngle: .pi)
    }
}
