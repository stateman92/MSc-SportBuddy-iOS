//
//  SettingsViewModelCommand.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 30..
//

enum SettingsViewModelCommand {
    case deleteImage
    case openImagePicker
    case toggleBatterySaving(to: Bool)
    case select(language: LanguageSettings)
    case close
    case logout
}
