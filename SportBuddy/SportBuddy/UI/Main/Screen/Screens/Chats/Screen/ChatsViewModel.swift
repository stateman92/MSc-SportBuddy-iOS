//
//  ChatsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine

final class ChatsViewModel: BaseViewModel<ChatsViewModelState, ChatsViewModelAction> {
    // MARK: - Action

    override func receiveAction(_ action: ChatsViewModelAction) {
        super.receiveAction(action)
        switch action {
        case .viewWillAppear: viewWillAppear()
        case .navigateToAddNewChatScreen: navigateToAddNewChatScreen()
        case let .didSelect(chatDto): didSelect(chatDto: chatDto)
        }
    }
}

// MARK: - Setups

extension ChatsViewModel {
    override func setup() {
        super.setup()

        chatStore.getChats()
            .sink { [unowned self] in sendState(.init(chats: $0)) }
            .store(in: &cancellables)
    }
}

// MARK: - Actions

extension ChatsViewModel {
    private func viewWillAppear() {
        chatAction.getChats()
            .sink()
            .store(in: &cancellables)
    }

    private func navigateToAddNewChatScreen() {
        navigatorService.present(AddNewChatScreen.self, type: .push)
    }

    private func didSelect(chatDto: ChatDTO) {
        navigatorService
            .present(ChatScreen.self, type: .push)
            .sendAction(.setChatType(.existing(chatDto)))
    }
}