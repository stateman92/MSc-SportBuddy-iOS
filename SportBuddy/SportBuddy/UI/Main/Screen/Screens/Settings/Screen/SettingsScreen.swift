//
//  SettingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

// swiftlint:disable:next colon
final class SettingsScreen:
    TabScreen<SettingsViewModelState, SettingsViewModelAction, SettingsDomain, SettingsViewModel> {
    // MARK: Properties

    private let tableView = AutoReversedTableView<ReversedTableViewCell, Int>(style: .insetGrouped) { cell, data in
        cell.textLabel?.text = "\(data)"
    }

    // MARK: Initialization

    init() {
        super.init(title: "Settings")
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
            $0.reloadData([[1, 2], [3, 4]])
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingsScreen: UITableViewDelegate { }
