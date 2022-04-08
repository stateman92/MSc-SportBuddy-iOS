//
//  SettingsServiceProtocol.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 08..
//

import Foundation

/// A protocol for managing key-value pairs persistently.
protocol SettingsServiceProtocol {
    init()

    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: Key) -> Bool where T: Codable

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: Key) -> T? where T: Codable

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: Key) -> Bool

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: Key) -> T? where T: Codable

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    func delete(forKey key: Key)
}

extension SettingsServiceProtocol {
    /// Encode the given object.
    /// - Parameters:
    ///   - object: the object.
    /// - Note:
    /// This method gives a unified method to encode objects.
    /// - Returns:
    ///     The encoded `Data?`.
    func encode<T>(object: T?) -> Data? where T: Codable {
        guard let object = object else { return nil }
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        return try? jsonEncoder.encode(object)
    }

    /// Decode the given data.
    /// - Parameters:
    ///   - data: the data.
    /// - Note:
    /// This method gives a unified method to decode objects.
    /// - Returns:
    ///     The decoded object.
    func decode<T>(data: Data?) -> T? where T: Codable {
        guard let data = data else { return nil }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try? jsonDecoder.decode(T.self, from: data)
    }
}
