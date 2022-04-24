//
//  SettingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class SettingsScreen: TabScreen<SettingsViewModel> {
    // MARK: Properties

    private let tableView = ReversedTableView<ReversedTableViewCell>(frame: .zero, style: .insetGrouped)
    private let data = Array([1, 2, 3, 4, 5, 6].reversed())

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
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReversedTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let int = data[indexPath.section * 3 + indexPath.row]
        cell.textLabel?.text = "\(indexPath.section). section, \(indexPath.row). row - \(int) data"
        cell.detailTextLabel?.text = "detailTextLabel"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsScreen: UITableViewDelegate { }
