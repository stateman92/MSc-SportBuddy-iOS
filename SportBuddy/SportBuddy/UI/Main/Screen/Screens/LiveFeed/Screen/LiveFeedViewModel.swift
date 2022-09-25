//
//  LiveFeedViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 12..
//

import Foundation

final class LiveFeedViewModel:
    BaseViewModel<LiveFeedViewModelState, LiveFeedViewModelCommand, LiveFeedDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: LiveFeedViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case let .sendMessage(message): sendMessage(message)
        case let .copy(message): copy(message)
        }
    }
}

// MARK: - Setups

extension LiveFeedViewModel {
    override func setup() {
        super.setup()
        store.getLiveFeed()
            .sink { [unowned self] in sendState(.init(liveFeed: $0)) }
            .store(in: &cancellables)
    }
}

// MARK: - Commands

extension LiveFeedViewModel {
    private func sendMessage(_ message: String) {
        let message = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        action
            .sendText(message: message)
            .sink()
            .store(in: &cancellables)
    }

    private func copy(_ message: String) {
        copyService.copy(string: message)
        toastService.showToast(with: .init(message: L10n.Live.Feed.Copy.success, type: .success))
    }
}
