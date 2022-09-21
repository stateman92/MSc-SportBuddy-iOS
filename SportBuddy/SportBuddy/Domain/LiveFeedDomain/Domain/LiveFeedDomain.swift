//
//  LiveFeedDomain.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol LiveFeedDomain: Domain {
    var store: LiveFeedStore { get }
    var action: LiveFeedAction { get }
}
