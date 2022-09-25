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
        let language = settingsCache.immediateValue?.languageSettings ?? preferredLanguage ?? .en
        if let bundle = language.bundle {
            Self.appbundle = bundle
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
