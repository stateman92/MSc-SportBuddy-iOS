//
//  ReversedTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

class ReversedTableViewCell: TableViewCell {
    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
}

// MARK: - Setups

extension ReversedTableViewCell {
    private func setupView() {
        contentView.transform = .init(rotationAngle: .pi)
    }
}

// MARK: - Public methods

extension ReversedTableViewCell {
    func set(reversed: Bool) {
        contentView.transform = .init(rotationAngle: reversed ? .pi : .zero)
    }
}
