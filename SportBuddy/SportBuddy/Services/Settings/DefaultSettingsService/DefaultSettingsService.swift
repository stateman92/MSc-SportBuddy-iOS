//
//  DefaultSettingsService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

import Foundation

/// A protocol for managing non-secure key-value pairs persistently.
protocol DefaultSettingsService: Initable {
    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: DefaultSettingsKey) -> Bool where T: Codable

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: DefaultSettingsKey) -> T? where T: Codable

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: DefaultSettingsKey) -> Bool

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: DefaultSettingsKey) -> T? where T: Codable

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    func delete(forKey key: DefaultSettingsKey)
}
