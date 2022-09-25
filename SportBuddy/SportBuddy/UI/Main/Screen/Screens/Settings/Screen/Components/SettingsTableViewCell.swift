//
//  SettingsTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import UIKit

final class SettingsTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    private let horizontalStack = StackView()
    private let verticalStack = StackView()
    private let titleLabel = Label()
    private let detailsLabel = Label()
    private let toggle = Switch()
    private let segmentedControl = SegmentedControl()
    private let segmentedControlStack = StackView()
    private var segmentedControlWidthConstraint: NSLayoutConstraint?
    private var toggleAction: UIAction?
    private var segmentedControlAction: UIAction?
    private var action = { }

    // MARK: Initializations

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
}

// MARK: - Setups

extension SettingsTableViewCell {
    private func setup() {
        setupHorizontalStack()
        setupVerticalStack()
        setupHorizontalSpacer()
        setupTitleLabel()
        setupDetailsLabel()
        setupToggle()
        setupSegmentedControlStack()
    }

    private func setupHorizontalStack() {
        horizontalStack.then {
            contentView.addSubview($0)
            $0.spacing = 8
            $0.alignment = .center
            $0.distribution = .fill
            $0.anchorToSuperview(top: 12, bottom: -12, leading: 12, trailing: -12)
        }
    }

    private func setupVerticalStack() {
        verticalStack.then {
            horizontalStack.addArrangedSubview($0)
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 8
            $0.addArrangedSubview(StackView().then {
                $0.addArrangedSubview(titleLabel)
                $0.addArrangedSubview(View())
            })
            $0.addArrangedSubview(StackView().then {
                $0.addArrangedSubview(detailsLabel)
                $0.addArrangedSubview(View())
            })
        }
    }

    private func setupHorizontalSpacer() {
        horizontalStack.addArrangedSubview(View())
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

    private func setupToggle() {
        toggle.then {
            horizontalStack.addArrangedSubview($0)
        }
    }

    private func setupSegmentedControlStack() {
        let firstSpacer = View()
        let secondSpacer = View()
        segmentedControlStack.then {
            verticalStack.addArrangedSubview($0)
            $0.addArrangedSubview(firstSpacer)
            $0.addArrangedSubview(segmentedControl)
            $0.addArrangedSubview(secondSpacer)
            segmentedControlWidthConstraint = $0.widthAnchor.constraint(equalTo: horizontalStack.widthAnchor)
        }
        secondSpacer.widthAnchor.constraint(equalTo: firstSpacer.widthAnchor).isActive = true
    }
}

// MARK: - Public methods

extension SettingsTableViewCell {
    func setup(with model: SettingsItem) {
        titleLabel.text = model.title
        detailsLabel.text = model.subtitle
        detailsLabel.isHidden = model.subtitle.trimmingCharacters(in: .whitespaces).isEmpty

        switch model.details {
        case .none:
            selectionStyle = .default
            segmentedControlStack.isHidden = true
            toggle.isHidden = true
            segmentedControlWidthConstraint?.isActive = false
        case let .toggle(state, action):
            selectionStyle = .none
            segmentedControlStack.isHidden = true
            toggle.setOn(state == .on ? true : false, animated: true)
            segmentedControlWidthConstraint?.isActive = false
            if let toggleAction {
                toggle.removeAction(toggleAction, for: .valueChanged)
            }
            toggleAction = .init { [unowned self] _ in
                action(toggle.isOn)
            }
            guard let toggleAction else { return }
            toggle.addAction(toggleAction, for: .valueChanged)
        case let .segments(segments, action):
            selectionStyle = .none
            segmentedControlStack.isHidden = false
            toggle.isHidden = true
            segmentedControl.removeAllSegments()
            segments.enumerated().forEach {
                segmentedControl.insertSegment(withTitle: $0.1.title, at: $0.0, animated: false)
            }
            segmentedControl.selectedSegmentIndex = segments.firstIndex { $0.selected } ?? UISegmentedControl.noSegment
            segmentedControlWidthConstraint?.isActive = true

            if let segmentedControlAction {
                segmentedControl.removeAction(segmentedControlAction, for: .valueChanged)
            }
            segmentedControlAction = .init { [unowned self] _ in
                let segment = segments[segmentedControl.selectedSegmentIndex]
                action(segment)
            }
            guard let segmentedControlAction else { return }
            segmentedControl.addAction(segmentedControlAction, for: .valueChanged)
        }
    }
}
