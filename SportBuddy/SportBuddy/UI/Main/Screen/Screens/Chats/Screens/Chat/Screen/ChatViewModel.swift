//
//  ChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class ChatViewModel: BaseViewModel<ChatViewModelState, ChatViewModelAction, ChatDomain> {
    // MARK: Properties

    private var chatType: ChatType? {
        didSet {
            guard let id = chatType?.id else { return }

            store
                .getChat(id: id)
                .sink { [unowned self] in sendState(.init(chat: $0)) }
                .store(in: &cancellables)
        }
    }

    // MARK: - Action

    override func receiveAction(_ action: ChatViewModelAction) {
        super.receiveAction(action)
        switch action {
        case let .setChatType(chatType): setChatType(chatType)
        }
    }
}

// MARK: - Setup

extension ChatViewModel {
    override func setup() {
        super.setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.action
                .sendText(toChat: self.chatType?.id ?? .init(),
                          toRecipient: self.chatType?.recipient(self.store.immediateToken ?? .init()) ?? .init(),
                          message: self.chatType?.text ?? "UNKNOWN")
                .sink()
                .store(in: &self.cancellables)
        }
    }
}

// MARK: - Actions

extension ChatViewModel {
    private func setChatType(_ chatType: ChatType) {
        self.chatType = chatType
    }
}
