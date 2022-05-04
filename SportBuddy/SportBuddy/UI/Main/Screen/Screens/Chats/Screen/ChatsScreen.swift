//
//  ChatsScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class ChatsScreen: TabScreen<ChatsViewModelState, ChatsViewModelAction, ChatsDomain, ChatsViewModel> {
    // MARK: Properties

    private let emptyStateView = AnimationView(animation: .searching)
    private let tableView = TableView(frame: .zero, style: .plain)
    private var chats: [ChatDTO] = [] {
        didSet {
            tableView.reloadData()
            emptyStateView.isHidden = !chats.isEmpty
            tableView.isHidden = chats.isEmpty
        }
    }

    // MARK: Initialization

    init() {
        super.init(title: "Chats")
    }

    // MARK: - State

    override func receiveState(_ state: ChatsViewModelState) {
        super.receiveState(state)
        chats = state.chats
    }
}

// MARK: - Lifecycle

extension ChatsScreen {
    override func setupView() {
        super.setupView()
        setupNavigationBar()
        setupEmptyStateView()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sendAction(.viewDidAppear)
    }
}

// MARK: - Setups

extension ChatsScreen {
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addBarButtonItemDidTap(_:))).then {
            $0.tintColor = .label
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

    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UITableViewCell.self)
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(top: 16, bottom: -16, leading: 16, trailing: -16, safeArea: true)
        }
    }
}

// MARK: - Helpers

extension ChatsScreen {
    @objc private func addBarButtonItemDidTap(_ sender: UIBarButtonItem) {
        sendAction(.navigateToAddNewChatScreen)
    }
}

// MARK: - UITableViewDataSource

extension ChatsScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.textLabel?.text = chats[indexPath.row].primaryId.uuidString
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendAction(.didSelect(chatDto: chats[indexPath.row]))
    }
}
