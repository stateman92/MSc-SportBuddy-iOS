//
//  SettingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

// swiftlint:disable:next colon
final class SettingsScreen:
    TabScreen<SettingsViewModelState, SettingsViewModelCommand, SettingsDomainImpl, SettingsViewModel> {
    // MARK: Properties

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
        tableView.reloadData([state.items])
    }
}

// MARK: - Lifecycle

extension SettingsScreen {
    override func setupView() {
        super.setupView()
        setupTableView()
    }
}

// MARK: - Setups

extension SettingsScreen {
    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(top: 8, bottom: -8, leading: 8, trailing: -8, safeArea: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.tableView.data(for: indexPath)
        if model.toggle == .none {
            model.action()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
