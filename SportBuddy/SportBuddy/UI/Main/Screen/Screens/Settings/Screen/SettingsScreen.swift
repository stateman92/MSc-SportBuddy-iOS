//
//  SettingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class SettingsScreen:
    TabScreen<SettingsViewModelState, SettingsViewModelCommand, SettingsDomainImpl, SettingsViewModel> {
    // MARK: Properties

    private let userImageView = CircleImageView()
    private let userNameLabel = Label()
    private let tableView = AutoReversedTableView<SettingsTableViewCell, SettingsItem>(
        style: .insetGrouped, reversed: false) { cell, data in
        cell.setup(with: data)
    }

    // MARK: Initialization

    init() {
        super.init(title: L10n.Settings.title)
    }

    override func receiveState(_ state: SettingsViewModelState) {
        super.receiveState(state)
        userImageView.image = .base64(string: state.image) ?? Images.fallbackProfileImage.image
        userNameLabel.text = state.name
        tableView.reloadData(state.items)
    }
}

// MARK: - Lifecycle

extension SettingsScreen {
    override func setupView() {
        super.setupView()
        setupUserImageView()
        setupUserNameLabel()
        setupTableView()
    }
}

// MARK: - Setups

extension SettingsScreen {
    private func setupUserImageView() {
        userImageView.then {
            view.addSubview($0)
            $0.anchorToSuperview(top: 8, safeArea: true)
            $0.anchorToCenterX()
            $0.heightAnchor.constraint(equalToConstant: 150).then {
                $0.priority = .defaultHigh
                $0.isActive = true
            }
            $0.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.2).isActive = true
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 25).isActive = true
        }
    }

    private func setupUserNameLabel() {
        userNameLabel.then {
            view.addSubview($0)
            $0.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8).isActive = true
            $0.anchorToCenterX()
            $0.numberOfLines = .zero
            $0.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 25).isActive = true
        }
    }

    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
            $0.anchorToSuperview(bottom: -8, leading: 8, trailing: -8, safeArea: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.tableView.data(for: indexPath)
        if model.details == .none {
            model.action()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
