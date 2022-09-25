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
    case notSet

    var bundle: Bundle? {
        guard let path = Bundle.main.path(forResource: rawValue, ofType: "lproj") else { return nil }
        return Bundle(path: path)
    }

    var localizedTitle: String {
        "abc"
    }
}
