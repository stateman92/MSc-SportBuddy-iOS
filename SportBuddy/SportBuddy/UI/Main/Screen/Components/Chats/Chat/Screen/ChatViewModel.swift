//
//  ChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class ChatViewModel: BaseViewModel {
    @LazyInjected private var userCache: UserCache

    var recipientId: UUID? {
        didSet {
            guard let recipientId = recipientId else { return }
            chatStore.getCreatedChatId()
                .sink { [unowned self] in chatId = $0 }
                .store(in: &cancellables)
        }
    }

    var chatId: UUID? {
        didSet {
            guard let chatId = chatId else { return }
            chatStore
                .getChat(id: chatId)
                .sink { [unowned self] in chat = $0 }
                .store(in: &cancellables)
        }
    }

    @Published var chat: ChatDTO = .init(primaryId: .init(), users: [], chatEntries: [], image: .init())

    override init() {
        super.init()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            if let id = self.recipientId {
                self.chatAction
                    .sendText(toRecipient: id, message: "bla bla teszt 1")
                    .sink()
                    .store(in: &self.cancellables)
            } else if let id = self.chat.users.first(where: {
                $0 != self.userCache.immediateValue?.primaryId
            }) {
                self.chatAction
                    .sendText(toChat: self.chat.primaryId, toRecipient: id, message: "bla bla teszt 2")
                    .sink()
                    .store(in: &self.cancellables)
            }
        }
    }
}
