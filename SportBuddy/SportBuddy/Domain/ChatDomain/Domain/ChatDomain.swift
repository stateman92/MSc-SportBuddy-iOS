//
//  ChatDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol ChatDomain: Domain {
    var store: ChatStore { get }
    var action: ChatAction { get }
}
