//
//  ChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class ChatViewModel: BaseViewModel<ChatViewModelState, ChatViewModelAction, ChatDomain> {
    // MARK: Properties

    private var chatType: ChatType! {
        didSet {
            store
                .getChat(id: chatType.id)
                .sink { [unowned self] in sendState(.init(chat: $0)) }
                .store(in: &cancellables)
        }
    }

    // MARK: - Action

    override func receiveAction(_ action: ChatViewModelAction) {
        super.receiveAction(action)
        switch action {
        case let .setChatType(chatType): setChatType(chatType)
        case let .sendMessage(message): sendMessage(message)
        }
    }
}

// MARK: - Actions

extension ChatViewModel {
    private func setChatType(_ chatType: ChatType) {
        self.chatType = chatType
    }

    private func sendMessage(_ message: String) {
        let message = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        action
            .sendText(toChat: chatType.id,
                      toRecipient: chatType.recipient(store.immediateToken ?? .init()) ?? .init(),
                      message: message)
            .sink()
            .store(in: &cancellables)
    }
}
