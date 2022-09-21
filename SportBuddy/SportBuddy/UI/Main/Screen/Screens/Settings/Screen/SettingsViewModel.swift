//
//  SettingsViewModel.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

// swiftlint:disable:next colon
final class SettingsViewModel:
    BaseViewModel<SettingsViewModelState, SettingsViewModelCommand, SettingsDomainImpl> {
    // MARK: - Command

    override func receiveCommand(_ command: SettingsViewModelCommand) {
        super.receiveCommand(command)
        switch command {
        case .openImagePicker: openImagePicker()
        case let .toggleBatterySaving(state): toggleBatterySaving(to: state)
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
            guard let self = self,
                  let image = result[.editedImage] as? UIImage,
                  let base64 = image.jpegData(compressionQuality: 1)?.base64EncodedString() else { return }
            self.action.set(image: base64).sink().store(in: &self.cancellables)
            imagePickerController.dismiss(animated: true)
        })
    }

    private func toggleBatterySaving(to state: Bool) {
        action.set(batterySaving: state).sink().store(in: &cancellables)
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
        refreshSettingsItems(batterySaving: false)
        store.getBatterySavingSettings()
            .sink { [unowned self] in refreshSettingsItems(batterySaving: $0) }
            .store(in: &cancellables)
    }
}

// MARK: - Private methods

extension SettingsViewModel {
    private func refreshSettingsItems(batterySaving: Bool) {
        sendState(.init(items: [
            .init(title: L10n.Settings.image, action: { [weak self] in self?.receiveCommand(.openImagePicker) }),
            .init(title: L10n.Settings.battery,
                  subtitle: L10n.Settings.Battery.description,
                  toggle: batterySaving ? .on : .off,
                  action: { [weak self] in self?.receiveCommand(.toggleBatterySaving(to: !batterySaving)) }),
            .init(title: L10n.Settings.close, action: { [weak self] in self?.receiveCommand(.close) }),
            .init(title: L10n.Settings.logout) { [weak self] in self?.receiveCommand(.logout) }
        ]))
    }
}
