//
//  GroupsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol LiveFeedStore {
    func getLiveFeed() -> DomainStorePublisher<[LiveFeedResponseDTO]>
}
