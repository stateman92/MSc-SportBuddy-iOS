//
//  ChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class ChatViewModel: BaseViewModel<ChatViewModelState, ChatViewModelCommand, ChatDomain> {
    // MARK: Properties

    private var chatType: ChatType! {
        didSet {
            store
                .getChat(id: chatType.id)
                .sink { [unowned self] in sendState(.init(chat: $0)) }
                .store(in: &cancellables)
        }
    }

    // MARK: - Command

    override func receiveCommand(_ command: ChatViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .setChatType(chatType): setChatType(chatType)
        case let .sendMessage(message): sendMessage(message)
        case let .copy(message): copy(message)
        }
    }
}

// MARK: - Commands

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

    private func copy(_ message: String) {
        copyService.copy(string: message)
        toastService.showToast(with: .init(message: "Message copied!", type: .success))
    }
}
