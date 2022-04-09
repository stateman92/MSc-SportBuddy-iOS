//
//  SettingsService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

import Foundation

final class SettingsService {
    /// The common `UserDefaults`.
    private let defaults: UserDefaults

    init() {
        defaults = .standard
    }
}

extension SettingsService: SettingsServiceProtocol {
    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: Key) -> Bool where T: Codable {
        if let encoded = encode(object: object) {
            defaults.set(encoded, forKey: key.keyName)
            return true
        }
        return false
    }

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: Key) -> T? where T: Codable {
        decode(data: defaults.object(forKey: key.keyName) as? Data)
    }

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: Key) -> Bool {
        defaults.object(forKey: key.keyName) != nil
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: Key) -> T? where T: Codable {
        let object: T? = retrieve(forKey: key)
        delete(forKey: key)
        return object
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    func delete(forKey key: Key) {
        defaults.removeObject(forKey: key.keyName)
    }
}
