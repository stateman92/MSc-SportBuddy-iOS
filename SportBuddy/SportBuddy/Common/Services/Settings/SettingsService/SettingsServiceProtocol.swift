//
//  SettingsServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Foundation

/// A protocol for managing all types of key-value pairs persistently.
protocol SettingsServiceProtocol: Initable {
    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    ///   - secure: whether the value should be stored securly.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: Key, secure: Bool) -> Bool where T: Codable

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    ///   - secure: whether the value was secure.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: Key, secure: Bool) -> T? where T: Codable

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    ///   - secure: whether the value was secure.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: Key, secure: Bool) -> Bool

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    ///   - secure: whether the value was secure.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: Key, secure: Bool) -> T? where T: Codable

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    ///   - secure: whether the value was secure.
    func delete(forKey key: Key, secure: Bool)
}
