//
//  LiveFeedActionProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol LiveFeedAction {
    func sendText(message: String) -> DomainActionPublisher
}
