//
//  SettingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Combine
import UIKit

final class SettingsViewModel:
    BaseViewModel<SettingsViewModelState, SettingsViewModelCommand, SettingsDomainImpl> {
    // MARK: Properties

    @LazyInjected private var notificationService: NotificationService

    // MARK: - Command

    override func receiveCommand(_ command: SettingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case .deleteImage: deleteImage()
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
    private func deleteImage() {
        action.clearImage().sink().store(in: &cancellables)
    }

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
            guard let self, let image = (result[.editedImage] as? UIImage)?.resize(to: 100)?.base64 else { return }
            self.action.set(image: image).sink().store(in: &self.cancellables)
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
        Publishers.CombineLatest3(store.getBatterySavingSettings(), store.getLanguageSettings(), store.getUser())
            .sink { [unowned self] in
                refreshSettingsItems(image: $0.2.profileImage ?? .init(),
                                     name: $0.2.name,
                                     batterySaving: $0.0,
                                     languageSettings: $0.1)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private methods

extension SettingsViewModel {
    private func refreshSettingsItems(image: String,
                                      name: String,
                                      batterySaving: Bool,
                                      languageSettings: LanguageSettings) {
        sendState(.init(image: image, name: name, items: [
            [
                imageSettingsItem(showDeleteButton: image.isBase64),
                batterySettingsItem(batterySaving)
            ],
            [
                languageSettingsItem(languageSettings)
            ],
            [
                closeSettingsItem,
                logoutSettingsItem
            ]
        ]))
    }

    private func imageSettingsItem(showDeleteButton: Bool) -> SettingsItem {
        if showDeleteButton {
            return .init(title: L10n.Settings.image, details: .button(L10n.Settings.Image.deletion) { [weak self] in
                self?.receiveCommand(.deleteImage)
            })
        } else {
            return .init(title: L10n.Settings.image, action: { [weak self] in self?.receiveCommand(.openImagePicker) })
        }
    }

    private func batterySettingsItem(_ batterySaving: Bool) -> SettingsItem {
        .init(title: L10n.Settings.battery,
              subtitle: L10n.Settings.Battery.description,
              details: .toggle(batterySaving ? .on : .off, action: { [weak self] in
            self?.receiveCommand(.toggleBatterySaving(to: $0))
        }))
    }

    private func languageSettingsItem(_ languageSettings: LanguageSettings) -> SettingsItem {
        let segments = LanguageSettings.allCases.map {
            SettingsItem.Segment(id: $0.rawValue, title: $0.localizedTitle, selected: $0 == languageSettings)
        }
        return .init(title: L10n.Settings.language,
                     details: .segments(segments, action: { [weak self] in
            guard let selectedLanguage = LanguageSettings(rawValue: $0.id) else { return }
            let alertController = UIAlertController(title: L10n.Settings.Language.Alert.title,
                                                    message: L10n.Settings.Language.Alert.message,
                                                    preferredStyle: .actionSheet)
            alertController.addAction(.init(title: L10n.Settings.Language.Alert.Button.restart,
                                            style: .default,
                                            handler: { [weak self] _ in
                guard let self else { return }
                self.action.set(languageSettings: selectedLanguage)
                    .map { L10n.Settings.Language.Alert.Notification.title }
                    .flatMap { [unowned self] in
                        self.notificationService.sendNotification(title: $0)
                        return self.action.close()
                    }
                    .sink()
                    .store(in: &self.cancellables)
            }))
            alertController.addAction(.init(title: L10n.Settings.Language.Alert.Button.cancel,
                                            style: .cancel,
                                            handler: { _ in
                self?.receiveCommand(.select(language: languageSettings))
            }))
            self?.navigatorService.present(alertController, type: .present)
        }))
    }

    private var closeSettingsItem: SettingsItem {
        .init(title: L10n.Settings.close) { [weak self] in self?.receiveCommand(.close) }
    }

    private var logoutSettingsItem: SettingsItem {
        .init(title: L10n.Settings.logout) { [weak self] in self?.receiveCommand(.logout) }
    }
}
