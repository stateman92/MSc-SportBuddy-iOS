//
//  AddNewChatScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import UIKit

final class AddNewChatScreen: BaseScreen<AddNewChatViewModelState, AddNewChatViewModelAction, AddNewChatViewModel> {
    // MARK: Properties

    private let emptyStateView = AnimationView(animation: .searching)
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let searchController = UISearchController(searchResultsController: nil)
    private var users: [UserDTO] = [] {
        didSet {
            emptyStateView.isHidden = !users.isEmpty
            tableView.isHidden = users.isEmpty
            tableView.reloadData()
        }
    }

    // MARK: - State

    override func receiveState(_ state: AddNewChatViewModelState) {
        super.receiveState(state)
        users = state.users
    }
}

// MARK: - Lifecycle

extension AddNewChatScreen {
    override func setupView() {
        super.setupView()
        title = "Add new chat"
        setupSearchController()
        setupTableView()
        setupEmptyStateView()
    }
}

// MARK: - Setups

extension AddNewChatScreen {
    private func setupSearchController() {
        searchController.then {
            $0.searchBar.delegate = self
            navigationItem.searchController = $0
        }
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.allowsSelection = true
            $0.register(UITableViewCell.self)

            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(top: 16, bottom: -16, leading: 16, trailing: -16, safeArea: true)
        }
    }

    private func setupEmptyStateView() {
        emptyStateView.then {
            view.addSubview($0)
            $0.anchorToCenterX()
            $0.anchorToBottom(safeArea: true)
            $0.setSize(.init(width: 200, height: 200))
            $0.play()
        }
    }
}

// MARK: - UISearchBarDelegate

extension AddNewChatScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sendAction(.searchTermDidChange(searchText))
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        sendAction(.forceSearchTermDidChange(searchText))
    }
}

// MARK: - UITableViewDataSource

extension AddNewChatScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AddNewChatScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendAction(.didSelect(id: users[indexPath.row].primaryId))
    }
}
