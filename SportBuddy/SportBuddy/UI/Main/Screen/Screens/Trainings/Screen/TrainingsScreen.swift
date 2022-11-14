//
//  TrainingsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class TrainingsScreen:
    TabScreen<TrainingsViewModelState, TrainingsViewModelCommand, TrainingsDomainImpl, TrainingsViewModel> {
    // MARK: Properties

    private let tableView = AutoReversedTableView<TrainingsTableViewCell, ExerciseModel>(
        style: .insetGrouped, reversed: false) { cell, data in
        cell.setup(with: data)
    }

    // MARK: Initialization

    init() {
        super.init(title: L10n.Trainings.title)
    }

    override func receiveState(_ state: TrainingsViewModelState) {
        super.receiveState(state)
        tableView.reloadData(state.exerciseModels)
    }
}

// MARK: - Lifecycle

extension TrainingsScreen {
    override func setupView() {
        super.setupView()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sendCommand(.viewDidAppear)
    }
}

// MARK: - Setups

extension TrainingsScreen {
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

extension TrainingsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.tableView.data(for: indexPath)
        sendCommand(.select(id: model.id))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
