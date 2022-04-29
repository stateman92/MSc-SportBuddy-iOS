//
//  ChatsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine

final class ChatsViewModel: BaseViewModel {
    @Published var chats: [ChatDTO] = []

    override init() {
        super.init()

        chatStore.getChats()
            .sink { [unowned self] in chats = $0 }
            .store(in: &cancellables)
    }
}

extension ChatsViewModel {
    func viewWillAppear() {
        chatAction.getChats()
            .sink()
            .store(in: &cancellables)
    }

    func navigateToAddNewChatScreen() {
        navigatorService.present(AddNewChatScreen.self, type: .push).viewModel.didSelectRecipient = { [weak self] in
            self?.navigatorService.present(ChatScreen.self, type: .push).viewModel.chatType = .new(chatId: .init(),
                                                                                                   recipientId: $0)
        }
    }

    func didSelect(chatDto: ChatDTO) {
        navigatorService.present(ChatScreen.self, type: .push).viewModel.chatType = .existing(chatDto)
    }
}
