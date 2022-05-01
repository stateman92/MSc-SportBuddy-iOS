//
//  ChatScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import UIKit

final class ChatScreen: BaseScreen<ChatViewModelState, ChatViewModelAction, ChatDomain, ChatViewModel> {
    // MARK: Properties

    private let tableView = TableView(frame: .zero, style: .grouped)
    private var chat: ChatDTO? {
        didSet {
            title = chat?.primaryId.uuidString ?? .init()
            tableView.reloadData()
        }
    }

    // MARK: - State

    override func receiveState(_ state: ChatViewModelState) {
        super.receiveState(state)
        chat = state.chat
    }
}

// MARK: - Lifecycle

extension ChatScreen {
    override func setupView() {
        super.setupView()
        setupTableView()
    }
}

// MARK: - Setups

extension ChatScreen {
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
}

// MARK: - UITableViewDataSource

extension ChatScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chat?.chatEntries.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.textLabel?.text = chat?.chatEntries[indexPath.row].message
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatScreen: UITableViewDelegate { }
