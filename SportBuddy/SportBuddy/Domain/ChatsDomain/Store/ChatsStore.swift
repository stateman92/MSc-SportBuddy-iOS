//
//  ChatsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol ChatsStore {
    func getChats() -> DomainStorePublisher<[ChatDTO]>
}
