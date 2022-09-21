//
//  LiveFeedTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import UIKit

final class LiveFeedTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    @LazyInjected private var dateFormatterService: DateFormatterService
    private let userImageView = LoadableImageView()
    private let labelContentView = RoundedView()
    private let label = Label()
    private let dateLabel = Label()
    private var labelContentViewLeadingConstraint: NSLayoutConstraint?
    private var labelContentViewTrailingConstraint: NSLayoutConstraint?
    private var dateLabelConstraint: NSLayoutConstraint?
    var targetedPreview: UIView {
        labelContentView
    }

    // MARK: Initializations

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
}

// MARK: - Overridden methods

extension LiveFeedTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.cancelImageLoading()
    }
}

// MARK: - Setups

extension LiveFeedTableViewCell {
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 37 + 4 + 4).isActive = true

        setupImageView()
        setupLabelContentView()
        setupLabel()
        setupDateLabel()
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
            $0.multiplier = .constant(16)
            $0.backgroundColor = Color.primary.color.withAlphaComponent(0.33)
            contentView.addSubview($0)
            $0.anchorToSuperview(top: 8)
        }
    }

    private func setupLabel() {
        label.then {
            $0.textColor = .white
            $0.numberOfLines = .zero
            labelContentView.addSubview($0)
            $0.anchorToSuperview(top: 4, bottom: -4, leading: 8, trailing: -8)
        }
    }

    private func setupDateLabel() {
        dateLabel.then {
            $0.font = $0.font.withSize(11)
            $0.textColor = Color.primary.color.withAlphaComponent(0.33)
            $0.numberOfLines = .zero
            contentView.addSubview($0)
            $0.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4).isActive = true
            $0.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true
        }
    }
}

// MARK: - Public methods

extension LiveFeedTableViewCell {
    func setup(with model: LiveFeedResponseDTO) {
        label.text = model.message
        dateLabel.text = dateFormatterService.string(from: model.date, format: .dateTime)
        if let image = model.image {
            labelContentViewLeadingConstraint?.isActive = false
            labelContentViewLeadingConstraint = labelContentView.leadingAnchor.constraint(
                equalTo: userImageView.trailingAnchor,
                constant: 8
            )
            labelContentViewLeadingConstraint?.isActive = true

            labelContentViewTrailingConstraint?.isActive = false
            labelContentViewTrailingConstraint = labelContentView.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -8
            )
            labelContentViewTrailingConstraint?.isActive = true

//            userImageView.image = .init(base64Encoding: image)

            dateLabelConstraint?.isActive = false
            dateLabelConstraint = dateLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor)
            dateLabelConstraint?.isActive = true
        } else {
            labelContentViewLeadingConstraint?.isActive = false
            labelContentViewLeadingConstraint = labelContentView.leadingAnchor.constraint(
                greaterThanOrEqualTo: userImageView.trailingAnchor,
                constant: 8
            )
            labelContentViewLeadingConstraint?.isActive = true

            labelContentViewTrailingConstraint?.isActive = false
            labelContentViewTrailingConstraint = labelContentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            )
            labelContentViewTrailingConstraint?.isActive = true

            dateLabelConstraint?.isActive = false
            dateLabelConstraint = dateLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            dateLabelConstraint?.isActive = true
        }
    }
}
