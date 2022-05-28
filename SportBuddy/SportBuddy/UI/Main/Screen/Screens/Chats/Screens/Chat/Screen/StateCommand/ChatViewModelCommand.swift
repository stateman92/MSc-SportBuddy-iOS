//
//  ChatViewModelCommand.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

enum ChatViewModelCommand {
    case setChatType(ChatType)
    case sendMessage(String)
    case copy(String)
}
