//
//  ChatScreen.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import UIKit

final class ChatScreen: BaseScreen<ChatViewModelState, ChatViewModelCommand, ChatDomainImpl, ChatViewModel> {
    // MARK: Properties

    private let tableView = AutoReversedTableView<ChatTableViewCell, ChatEntryDTO>(style: .grouped) { cell, data in
        cell.setup(with: data)
    }
    private let inputField = ChatInputField()
    private var bottomAnchor: NSLayoutConstraint?
    @LazyInjected private var systemImageService: SystemImageService
    @LazyInjected private var toastService: ToastService

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
                self?.sendCommand(.sendMessage($0))
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

extension ChatScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        let message = self.tableView.data(for: indexPath).message
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying,
                                          previewProvider: nil) { [weak self] _ in
            guard let self = self else { return nil }
            return UIMenu(title: .init(), children: [self.shareAction(message: message),
                                                     self.copyAction(message: message),
                                                     self.deleteAction])
        }
    }

    func tableView(
        _ tableView: UITableView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        getTargetedPreview(for: configuration.identifier as? IndexPath)
    }

    func tableView(
        _ tableView: UITableView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        getTargetedPreview(for: configuration.identifier as? IndexPath)
    }
}

// MARK: - Private methods

extension ChatScreen {
    private func getTargetedPreview(for indexPath: IndexPath?) -> UITargetedPreview? {
        guard let indexPath = indexPath,
              let cell = tableView.cellForRow(at: indexPath) as? ChatTableViewCell else { return nil }

        return UITargetedPreview(view: cell.labelContentView,
                                 parameters: UIPreviewParameters().then { $0.backgroundColor = .clear })
    }

    private func shareAction(message: String) -> UIAction {
        .init(title: "Share",
              image: systemImageService.image(symbol: .squareAndArrowUp),
              handler: { [weak self] _ in self?.share(message: message) })
    }

    private func copyAction(message: String) -> UIAction {
        .init(title: "Copy",
              image: systemImageService.image(symbol: .docOnDoc),
              handler: { [weak self] _ in self?.sendCommand(.copy(message)) })
    }

    private var deleteAction: UIAction {
        .init(title: "Delete",
              image: systemImageService.image(symbol: .trash),
              attributes: .destructive,
              handler: { _ in })
    }

    private func share(message: String) {
        let activityViewController = UIActivityViewController(activityItems: [message],
                                                              applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
            if completed {
                self?.toastService.showToast(with: .init(message: "Message shared!", type: .success))
            } else {
                self?.toastService.showToast(with: .init(message: "Message cannot be shared!", type: .error))
            }
        }
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true)
    }
}
