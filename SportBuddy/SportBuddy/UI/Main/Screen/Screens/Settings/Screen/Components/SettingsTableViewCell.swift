//
//  SettingsTableViewCell.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

import UIKit

final class SettingsTableViewCell: ReversedTableViewCell {
    // MARK: Properties

    private let toggle = Switch()
    private var action = { }

    // MARK: Initializations

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Public methods

extension SettingsTableViewCell {
    func setup(with model: SettingsItem) {
        accessoryView = toggle
        selectionStyle = .none
        switch model.toggle {
        case .none:
            accessoryView = nil
            selectionStyle = .default
        case .on: toggle.setOn(true, animated: true)
        case .off: toggle.setOn(false, animated: true)
        }

        textLabel?.text = model.title
        detailTextLabel?.text = model.subtitle

        toggle.addAction(for: .valueChanged, model.action)

        detailTextLabel?.numberOfLines = .zero
//        detailTextLabel?.lineBreakMode = .byWordWrapping
        detailTextLabel?.sizeToFit()
    }
}
