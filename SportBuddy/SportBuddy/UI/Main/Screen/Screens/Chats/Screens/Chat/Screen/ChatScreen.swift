//
//  ChatScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import UIKit

final class ChatScreen: BaseScreen<ChatViewModelState, ChatViewModelAction, ChatDomain, ChatViewModel> {
    // MARK: Properties

    private let tableView = AutoReversedTableView<ChatTableViewCell, ChatEntryDTO>(style: .grouped) { cell, data in
        cell.setup(with: data)
    }
    private let inputField = ChatInputField()
    private var bottomAnchor: NSLayoutConstraint?

    // MARK: - State

    override func receiveState(_ state: ChatViewModelState) {
        super.receiveState(state)
        title = state.chat.primaryId.uuidString
        tableView.reloadData([state.chat.chatEntries].compactMap { $0 })
    }
}

// MARK: - Lifecycle

extension ChatScreen {
    override func setupView() {
        super.setupView()
        setupTableView()
        setupInputField()
        setupKeyboardObserving()
    }
}

// MARK: - Setups

extension ChatScreen {
    private func setupTableView() {
        tableView.then {
            $0.delegate = self
            $0.separatorStyle = .none
            $0.allowsSelection = true

            $0.backgroundColor = .clear
            view.addSubview($0)
            $0.anchorToSuperview(top: 16, leading: 16, trailing: -16, safeArea: true)
        }
    }

    private func setupInputField() {
        inputField.then {
            view.addSubview($0)
            $0.anchorToSuperview(leading: .zero, trailing: .zero, safeArea: true)
            tableView.bottomAnchor.constraint(equalTo: $0.topAnchor, constant: -8).isActive = true
            bottomAnchor = $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).then {
                $0.isActive = true
            }
            $0.sendText = { [weak self] in
                self?.sendAction(.sendMessage($0))
            }
        }
    }

    private func setupKeyboardObserving() {
        AnimatedKeyboardObserver
            .shared
            .beforeShowKeyboard
            .sink { [unowned self] in
                bottomAnchor?.isActive = false
                bottomAnchor = inputField
                    .bottomAnchor
                    .constraint(equalTo: view.bottomAnchor, constant: -(UIScreen.main.bounds.height - $0.1.minY))
                    .then { $0.isActive = true }
            }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .showingKeyboard
            .sink { [unowned self] _ in view.layoutIfNeeded() }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .beforeHideKeyboard
            .sink { [unowned self] in
                bottomAnchor?.isActive = false
                bottomAnchor = inputField
                    .bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                constant: -(UIScreen.main.bounds.height - $0.1.minY))
                    .then { $0.isActive = true }
            }
            .store(in: &cancellables)

        AnimatedKeyboardObserver
            .shared
            .hidingKeyboard
            .sink { [unowned self] _ in view.layoutIfNeeded() }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDelegate

extension ChatScreen: UITableViewDelegate { }
