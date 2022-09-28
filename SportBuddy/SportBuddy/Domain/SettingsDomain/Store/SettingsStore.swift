//
//  SettingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol SettingsStore {
    func getUser() -> DomainStorePublisher<UserDTO>
    func getBatterySavingSettings() -> DomainStorePublisher<Bool>
    func getLanguageSettings() -> DomainStorePublisher<LanguageSettings>
}
