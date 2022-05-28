//
//  ChatTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

final class ChatTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    private let userImageView = LoadableImageView()
    let labelContentView = RoundedView()
    private let label = Label()

    // MARK: Initializations

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
}

// MARK: - Overridden methods

extension ChatTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.cancelImageLoading()
    }
}

// MARK: - Setups

extension ChatTableViewCell {
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 37 + 4 + 4).isActive = true

        setupImageView()
        setupLabelContentView()
        setupLabel()
    }

    private func setupImageView() {
        userImageView.then {
            contentView.addSubview($0)
            $0.anchorToSuperview(top: 4, leading: .zero)
            $0.setSize(.init(width: 37, height: 37))
        }
    }

    private func setupLabelContentView() {
        labelContentView.then {
            $0.backgroundColor = Color.primary.color.withAlphaComponent(0.33)
            contentView.addSubview($0)
            $0.anchorToSuperview(top: 8)
            $0.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true
            $0.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8).isActive = true
            $0.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8).isActive = true
        }
    }

    private func setupLabel() {
        label.then {
            $0.textColor = .white
            $0.numberOfLines = .zero
            labelContentView.addSubview($0)
            $0.anchorToSuperview(top: 4, bottom: -4, leading: 4, trailing: -4)
        }
    }
}

// MARK: - Public methods

extension ChatTableViewCell {
    func setup(with model: ChatEntryDTO) {
        label.text = model.message
    }
}
