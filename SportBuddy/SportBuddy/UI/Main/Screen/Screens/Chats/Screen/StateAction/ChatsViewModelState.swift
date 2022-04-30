//
//  ChatsViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct ChatsViewModelState {
    let chats: [ChatDTO]
}

extension ChatsViewModelState: Initable {
    init() {
        self.init(chats: .init())
    }
}
