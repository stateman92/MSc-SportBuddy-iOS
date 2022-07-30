//
//  ChatViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct ChatViewModelState {
    let chat: ChatDTO
}

extension ChatViewModelState: Initable {
    init() {
        self.init(chat: .init(primaryId: .init(), users: .init(), chatEntries: .init(), image: .init()))
    }
}

extension ChatViewModelState: Equatable { }
