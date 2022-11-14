//
//  BaseTwoRowTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 11. 13..
//

import UIKit

class BaseTwoRowTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    private let verticalStack = StackView()
    private let titleLabel = Label()
    private let detailsLabel = Label()

    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
}

// MARK: - Setups

extension BaseTwoRowTableViewCell {
    private func setup() {
        setupVerticalStack()
        setupTitleLabel()
        setupDetailsLabel()
    }

    private func setupVerticalStack() {
        verticalStack.then {
            addSubview($0)
            $0.anchorToSuperview(top: 12, bottom: -12, leading: 12, trailing: -12)
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 8
            $0.addArrangedSubview(StackView().then {
                $0.addArrangedSubview(titleLabel)
                $0.addArrangedSubview(View())
            })
            $0.addArrangedSubview(StackView().then {
                $0.addArrangedSubview(detailsLabel)
            })
        }
    }

    private func setupTitleLabel() {
        titleLabel.then {
            $0.numberOfLines = .zero
        }
    }

    private func setupDetailsLabel() {
        detailsLabel.then {
            $0.numberOfLines = .zero
            $0.font = $0.font.withSize(13)
        }
    }
}

// MARK: - Public methods

extension BaseTwoRowTableViewCell {
    func setup(with title: String?, details: String?) {
        titleLabel.text = title
        detailsLabel.text = details
    }
}
