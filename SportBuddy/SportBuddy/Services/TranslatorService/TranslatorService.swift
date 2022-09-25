//
//  TranslatorService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import Foundation

/// A protocol for localizing the app.
protocol TranslatorService {
    /// Set the language based on  first supported language or if none is supported, English.
    func start()
}

extension TranslatorService {
    private var preferredLanguages: [String] {
        NSLocale.preferredLanguages
    }

    var preferredLanguage: LanguageSettings? {
        preferredLanguages
            .reversed()
            .map { String($0.prefix(2)).lowercased() }
            .compactMap(LanguageSettings.init(rawValue:))
            .first
    }
}
