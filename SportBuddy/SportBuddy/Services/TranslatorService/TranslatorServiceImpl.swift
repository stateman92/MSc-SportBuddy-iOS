//
//  TranslatorServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import Foundation

final class TranslatorServiceImpl {
    // MARK: Properties

    private static var appbundle = Bundle.main
    @LazyInjected private var settingsCache: SettingsCache
}

// MARK: - TranslatorService

extension TranslatorServiceImpl: TranslatorService {
    func start() {
        if let bundle = settingsCache.immediateValue?.languageSettings.bundle {
            Self.appbundle = bundle
        } else if let preferredLanguage, let bundle = preferredLanguage.bundle {
            Self.appbundle = bundle
            settingsCache.modify { $0.languageSettings = .system }
        } else if let bundle = LanguageSettings.en.bundle {
            Self.appbundle = bundle
            settingsCache.modify { $0.languageSettings = .en }
        }
    }
}

// MARK: - Public methods

extension TranslatorServiceImpl {
    /// A wrapper function to get the localized `String` for the given key.
    static func string(_ key: String, _ tableName: String?, _ value: String) -> String {
        appbundle.localizedString(forKey: key, value: value, table: nil)
    }
}
