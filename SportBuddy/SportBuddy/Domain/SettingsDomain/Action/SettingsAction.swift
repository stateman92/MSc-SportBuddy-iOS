//
//  SettingsAction.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

protocol SettingsAction {
    func set(image: String) -> DomainActionPublisher
    func set(batterySaving: Bool) -> DomainActionPublisher
    func set(languageSettings: LanguageSettings) -> DomainActionPublisher
    func logout() -> DomainActionPublisher
    func close() -> DomainActionPublisher
}
