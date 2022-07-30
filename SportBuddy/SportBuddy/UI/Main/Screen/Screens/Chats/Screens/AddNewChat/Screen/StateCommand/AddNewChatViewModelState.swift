//
//  AddNewChatViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

struct AddNewChatViewModelState {
    let users: [UserDTO]
}

extension AddNewChatViewModelState: Initable {
    init() {
        self.init(users: .init())
    }
}

extension AddNewChatViewModelState: Equatable { }
