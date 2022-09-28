//
//  SettingsServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Foundation

/// A protocol for managing all types of key-value pairs persistently.
/// Note: simulator doesn't support keychain.
final class SettingsServiceImpl {
    // MARK: Properties

    @LazyInjected private var defaultSettingsService: DefaultSettingsService
    @LazyInjected private var secureSettingsService: SecureSettingsService
}

// MARK: - SettingsService

extension SettingsServiceImpl: SettingsService {
    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: SettingsKey) -> Bool where T: Codable {
        if key.secure, !isSimulator {
            return secureSettingsService.save(object: object, forKey: key.asSecureSettingsKey)
        } else {
            return defaultSettingsService.save(object: object, forKey: key.asDefaultSettingsKey)
        }
    }

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: SettingsKey) -> T? where T: Codable {
        if key.secure, !isSimulator {
            return secureSettingsService.retrieve(forKey: key.asSecureSettingsKey)
        } else {
            return defaultSettingsService.retrieve(forKey: key.asDefaultSettingsKey)
        }
    }

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: SettingsKey) -> Bool {
        if key.secure, !isSimulator {
            return secureSettingsService.has(key: key.asSecureSettingsKey)
        } else {
            return defaultSettingsService.has(key: key.asDefaultSettingsKey)
        }
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: SettingsKey) -> T? where T: Codable {
        if key.secure, !isSimulator {
            return secureSettingsService.delete(forKey: key.asSecureSettingsKey)
        } else {
            return defaultSettingsService.delete(forKey: key.asDefaultSettingsKey)
        }
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    func delete(forKey key: SettingsKey) {
        if key.secure, !isSimulator {
            secureSettingsService.delete(forKey: key.asSecureSettingsKey)
        } else {
            defaultSettingsService.delete(forKey: key.asDefaultSettingsKey)
        }
    }
}
