//
//  LanguageSettings.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import Foundation

enum LanguageSettings: String, Codable, CaseIterable {
    case en
    case hu
    case system

    var bundle: Bundle? {
        Bundle.main.path(forResource: rawValue, ofType: Constants.Extensions.lproj.rawValue).flatMap(Bundle.init(path:))
    }

    var localizedTitle: String {
        switch self {
        case .en: return L10n.Settings.Language.english
        case .hu: return L10n.Settings.Language.hungarian
        case .system: return L10n.Settings.Language.system
        }
    }
}
