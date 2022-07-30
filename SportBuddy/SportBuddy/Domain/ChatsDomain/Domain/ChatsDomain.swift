//
//  ChatsDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol ChatsDomain: Domain {
    var store: ChatsStore { get }
    var action: ChatsAction { get }
}
