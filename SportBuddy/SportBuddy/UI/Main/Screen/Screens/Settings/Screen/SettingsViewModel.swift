//
//  SettingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

final class SettingsViewModel:
    BaseViewModel<SettingsViewModelState, SettingsViewModelCommand, SettingsDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: SettingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case .openImagePicker: openImagePicker()
        case let .toggleBatterySaving(state): toggleBatterySaving(to: state)
        case let .select(language): select(language: language)
        case .close: close()
        case .logout: logout()
        }
    }
}

// MARK: - Commands

extension SettingsViewModel {
    private func openImagePicker() {
        let imagePickerController = UIImagePickerController().then {
            $0.setMediaType(mediaType: .image)
            $0.allowsEditing = true
            $0.sourceType = .photoLibrary
            navigatorService.present($0, type: .present)
        }
        imagePickerController.set(didTapCancel: { _ in
            imagePickerController.dismiss(animated: true)
        }, didFinish: { [weak self] _, result in
            guard let self,
                  let image = result[.editedImage] as? UIImage,
                  let base64 = image.jpegData(compressionQuality: 1)?.base64EncodedString() else { return }
            self.action.set(image: base64).sink().store(in: &self.cancellables)
            imagePickerController.dismiss(animated: true)
        })
    }

    private func toggleBatterySaving(to state: Bool) {
        action.set(batterySaving: state).sink().store(in: &cancellables)
    }

    private func select(language: LanguageSettings) {
        action.set(languageSettings: language).sink().store(in: &cancellables)
    }

    private func close() {
        action.close().sink().store(in: &cancellables)
    }

    private func logout() {
        action.logout().sink().store(in: &cancellables)
    }
}

// MARK: - Setups

extension SettingsViewModel {
    override func setup() {
        super.setup()
        store.getBatterySavingSettings()
            .combineLatest(store.getLanguageSettings())
            .sink { [unowned self] in refreshSettingsItems(batterySaving: $0, languageSettings: $1) }
            .store(in: &cancellables)
    }
}

// MARK: - Private methods

extension SettingsViewModel {
    private func refreshSettingsItems(batterySaving: Bool, languageSettings: LanguageSettings) {
        let languageSegments = LanguageSettings.allCases.map {
            SettingsItem.Segment(id: $0.rawValue, title: $0.localizedTitle, selected: $0 == languageSettings)
        }
        sendState(.init(items: [
            [.init(title: L10n.Settings.image, action: { [weak self] in self?.receiveCommand(.openImagePicker) }),
             .init(title: L10n.Settings.battery,
                   subtitle: L10n.Settings.Battery.description,
                   details: .toggle(batterySaving ? .on : .off, action: { [weak self] in
                       self?.receiveCommand(.toggleBatterySaving(to: $0))
                   }))],
            [.init(title: "Language",
                   details: .segments(languageSegments, action: { [weak self] in
                       guard let selectedLanguage = LanguageSettings(rawValue: $0.id) else { return }
                       self?.receiveCommand(.select(language: selectedLanguage))
                   }))],
            [.init(title: L10n.Settings.close, action: { [weak self] in self?.receiveCommand(.close) }),
             .init(title: L10n.Settings.logout) { [weak self] in self?.receiveCommand(.logout) }]
        ]))
    }
}
