//
//  AutoReversedTableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

class AutoReversedTableView<Cell: ReversedTableViewCell, Data>: ReversedTableView, UITableViewDataSource {
    // MARK: Properties

    private var data: [[Data]] = .init()
    private let cellConfig: (Cell, Data) -> Void
    override var dataSource: UITableViewDataSource? {
        didSet {
            if dataSource !== self {
                fatalError("AutoReversedTableView.dataSource must be set to self. Do not set it directly.")
            }
        }
    }

    // MARK: Initialization

    init(style: Style, cellConfig: @escaping (Cell, Data) -> Void) {
        self.cellConfig = cellConfig
        super.init(style: style)
        setupView()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = dequeueReusableCell(indexPath: indexPath)
        cellConfig(cell, data[indexPath.section][indexPath.row])
        return cell
    }
}

// MARK: - Setups

extension AutoReversedTableView {
    private func setupView() {
        register(Cell.self)
        dataSource = self
    }
}

// MARK: - Public methods

extension AutoReversedTableView {
    func reloadData(_ data: [[Data]]) {
        self.data = data.reversed().map { $0.reversed() }
        super.reloadData()
    }
}
