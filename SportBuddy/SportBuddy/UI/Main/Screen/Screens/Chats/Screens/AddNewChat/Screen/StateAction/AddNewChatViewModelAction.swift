//
//  AddNewChatViewModelAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

import Foundation

enum AddNewChatViewModelAction {
    case searchTermDidChange(String)
    case forceSearchTermDidChange(String)
    case didSelect(id: UUID)
}
