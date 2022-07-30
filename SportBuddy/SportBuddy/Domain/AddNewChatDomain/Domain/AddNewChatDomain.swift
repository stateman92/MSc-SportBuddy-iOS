//
//  AddNewChatDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol AddNewChatDomain: Domain {
    var store: AddNewChatStore { get }
    var action: AddNewChatAction { get }
}
