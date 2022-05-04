//
//  ReversedTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

class ReversedTableViewCell: TableViewCell {
    // MARK: Initializations

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
