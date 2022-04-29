//
//  ChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

final class ChatViewModel: BaseViewModel {
    enum ChatType {
        case existing(ChatDTO)
        case new(chatId: UUID, recipientId: UUID)

        fileprivate var id: UUID {
            switch self {
            case let .existing(chatDto): return chatDto.primaryId
            case let .new(chatId, _): return chatId
            }
        }

        fileprivate var text: String {
            switch self {
            case .existing: return "Existing chat!"
            case .new: return "New chat!"
            }
        }

        fileprivate func recipient(_ userCache: UserCache) -> UUID? {
            guard let userId = userCache.immediateValue?.primaryId else {
                assertionFailure("User's id didn't find!")
                return nil
            }
            switch self {
            case let .existing(chatDto): return chatDto.users.first { $0 != userId }
            case let .new(_, recipientId): return recipientId
            }
        }
    }

    @LazyInjected private var userCache: UserCache

    var chatType: ChatType? {
        didSet {
            guard let id = chatType?.id else { return }

            chatStore
                .getChat(id: id)
                .sink { [unowned self] in chat = $0 }
                .store(in: &cancellables)
        }
    }

    @Published var chat: ChatDTO = .init(primaryId: .init(), users: [], chatEntries: [], image: .init())

    override init() {
        super.init()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.chatAction
                .sendText(toChat: self.chatType?.id ?? .init(),
                          toRecipient: self.chatType?.recipient(self.userCache) ?? .init(),
                          message: self.chatType?.text ?? "UNKNOWN")
                .sink()
                .store(in: &self.cancellables)
        }
    }
}
