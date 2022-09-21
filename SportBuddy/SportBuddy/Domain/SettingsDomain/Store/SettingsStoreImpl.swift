//
//  SettingsStoreImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SettingsStoreImpl: DomainImpl {
    // MARK: Properties

    @LazyInjected private var settingsCache: SettingsCache
}

// MARK: - SettingsStore

extension SettingsStoreImpl: SettingsStore {
    func getBatterySavingSettings() -> DomainStorePublisher<Bool> {
        settingsCache.value().map(\.?.batterySaving).autoEraseOnMain()
    }
}
