//
//  AddNewChatViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 27..
//

import Foundation

// swiftlint:disable:next colon
final class AddNewChatViewModel:
    BaseViewModel<AddNewChatViewModelState, AddNewChatViewModelCommand, AddNewChatDomain> {
    // MARK: Properties

    @Throttling(wrappedValue: .init(), seconds: 0.66) private var searchTerm: String

    // MARK: - Command

    override func receiveCommand(_ command: AddNewChatViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .searchTermDidChange(string): searchTermDidChange(string)
        case let .forceSearchTermDidChange(string): forceSearchTermDidChange(string)
        case let .didSelect(id): didSelect(id: id)
        }
    }
}

// MARK: - Setups

extension AddNewChatViewModel {
    override func setup() {
        super.setup()
        store
            .searchedUsers
            .sink { [unowned self] in sendState(.init(users: $0)) }
            .store(in: &cancellables)

        $searchTerm.on { [weak self] in
            guard let self = self else { return }
            self.action.searchUsers(searchTerm: $0).sink().store(in: &self.cancellables)
        }
    }
}

// MARK: - Commands

extension AddNewChatViewModel {
    private func searchTermDidChange(_ string: String) {
        searchTerm = string
    }

    private func forceSearchTermDidChange(_ string: String) {
        $searchTerm.force(value: string)
    }

    private func didSelect(id: UUID) {
        navigatorService
            .present(ChatScreen.self, type: .push) { [weak self] in
                self?.navigatorService.pop(reverseIndex: 1)
            }
            .sendCommand(.setChatType(.new(chatId: .init(), recipientId: id)))
        action.clearSearchedUser().sink().store(in: &cancellables)
    }
}
