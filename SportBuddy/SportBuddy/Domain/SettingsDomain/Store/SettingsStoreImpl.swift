//
//  SettingsStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var settingsCache: SettingsCache
    @LazyInjected private var userCache: UserCache
}

// MARK: - SettingsStore

extension SettingsStoreImpl: SettingsStore {
    func getUser() -> DomainStorePublisher<UserDTO> {
        userCache.value().compactMap(\.?.user).autoEraseOnMain()
    }

    func getBatterySavingSettings() -> DomainStorePublisher<Bool> {
        settingsCache.value().map { $0?.batterySaving ?? false }.autoEraseOnMain()
    }

    func getLanguageSettings() -> DomainStorePublisher<LanguageSettings> {
        settingsCache.value().map { $0?.languageSettings ?? .system }.autoEraseOnMain()
    }
}
