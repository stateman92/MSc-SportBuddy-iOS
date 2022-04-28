//
//  ReversedTableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 24..
//

import UIKit

class ReversedTableView<Cell: ReversedTableViewCell>: TableView {
    // MARK: Initialization

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
}

// MARK: - Setups

extension ReversedTableView {
    private func setupView() {
        transform = .init(rotationAngle: .pi)
        register(Cell.self)
    }
}

class ReversedTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension ReversedTableViewCell {
    private func setupView() {
        contentView.transform = .init(rotationAngle: .pi)
    }
}
