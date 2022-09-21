//
//  MockSettingsStore.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 04..
//

import Combine

final class MockSettingsStore: DomainImpl { }

// MARK: - SettingsStore

extension MockSettingsStore: SettingsStore {
    func getBatterySavingSettings() -> DomainStorePublisher<Bool> {
        Just(false).autoEraseOnMain()
    }
}
