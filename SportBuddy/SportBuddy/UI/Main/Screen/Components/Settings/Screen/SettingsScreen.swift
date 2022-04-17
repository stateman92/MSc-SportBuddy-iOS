//
//  SettingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class SettingsScreen: TabScreen<SettingsViewModel> {
    // MARK: Properties

    private let tableView = FadingTableView(frame: .zero, style: .insetGrouped)

    // MARK: Initialization

    override init() {
        super.init()
        title = "Settings"
    }
}

// MARK: - Lifecycle

extension SettingsScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setups

extension SettingsScreen {
    private func setupView() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.then {
            $0.register(UITableViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(top: 8, bottom: -8, leading: 8, trailing: -8, safeArea: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension SettingsScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.textLabel?.text = "textLabel"
        cell.detailTextLabel?.text = "detailTextLabel"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsScreen: UITableViewDelegate { }
