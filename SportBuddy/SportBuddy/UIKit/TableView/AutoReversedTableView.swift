//
//  AutoReversedTableView.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import UIKit

final class AutoReversedTableView<Cell: ReversedTableViewCell, Data>: ReversedTableView, UITableViewDataSource {
    // MARK: Properties

    private var data: [[Data]] = .init()
    private let cellConfig: (Cell, Data) -> Void
    private let reversed: Bool
    override var dataSource: UITableViewDataSource? {
        didSet {
            if dataSource !== self {
                fatalError("AutoReversedTableView.dataSource must be set to self. Do not set it directly.")
            }
        }
    }

    // MARK: Initialization

    init(style: Style, reversed: Bool = true, cellConfig: @escaping (Cell, Data) -> Void) {
        self.cellConfig = cellConfig
        self.reversed = reversed
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
        cell.set(reversed: reversed)
        cellConfig(cell, data[indexPath.section][indexPath.row])
        return cell
    }
}

// MARK: - Setups

extension AutoReversedTableView {
    private func setupView() {
        register(Cell.self)
        dataSource = self
        transform = .init(rotationAngle: reversed ? .pi : .zero)
    }
}

// MARK: - Public methods

extension AutoReversedTableView {
    func reloadData(_ data: [[Data]]) {
        self.data = reversed ? data.reversed().map { $0.reversed() } : data
        super.reloadData()
    }

    func data(for indexPath: IndexPath) -> Data {
        data[indexPath.section][indexPath.row]
    }
}
