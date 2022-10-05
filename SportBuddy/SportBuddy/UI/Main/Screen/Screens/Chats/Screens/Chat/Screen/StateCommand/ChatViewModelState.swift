//
//  ChatViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import Foundation

struct ChatViewModelState {
    let chat: ChatDTO
    let currentUserId: UUID
    let image: String
}

extension ChatViewModelState: Initable {
    init() {
        self.init(chat: .init(chatEntries: .init(),
                              image: .init(),
                              primaryId: .init(),
                              users: .init(),
                              otherParty: .init()),
                  currentUserId: .init(),
                  image: .init())
    }
}

extension ChatViewModelState: Equatable { }
