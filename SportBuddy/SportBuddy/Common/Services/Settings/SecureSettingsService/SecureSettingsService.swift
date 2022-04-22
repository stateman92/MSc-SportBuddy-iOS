//
//  SecureSettingsService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 17..
//

import Valet

/// A class for managing secure key-value pairs persistently.
final class SecureSettingsService {
    // MARK: Nested types

    private enum Constants {
        static var teamId: String { "7KJTVFSV88" }
        static var accessGroup: String { "hu.bme.aut.SportBuddy1" }
    }

    // MARK: Properties

    @LazyInjected private var coderService: CoderServiceProtocol
    private let valet = Valet.sharedGroupValet(with: SharedGroupIdentifier(appIDPrefix: Constants.teamId,
                                                                           nonEmptyGroup: Constants.accessGroup)!,
                                               accessibility: .afterFirstUnlock)

    // MARK: Initialization

    /// Initialize the service.
    init() { }
}

// MARK: - SecureSettingsServiceProtocol

extension SecureSettingsService: SecureSettingsServiceProtocol {
    /// Save a `Codable` value to the device.
    /// - Parameters:
    ///   - object: the `Codable` to be stored.
    ///   - forKey: the key with that will be associated.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func save<T>(object: T?, forKey key: Key) -> Bool where T: Codable {
        guard let data = coderService.encode(object: object) else { return false }
        do {
            try valet.setObject(data, forKey: key.keyName)
            return true
        } catch {
            dump(error)
            return false
        }
    }

    /// Retrieve a `Codable` from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be returned.
    /// - Note:
    /// If nothing is stored for the given key (or some error happened), return `nil`.
    /// - Returns:
    ///     The value for the given key.
    func retrieve<T>(forKey key: Key) -> T? where T: Codable {
        guard let data = try? valet.object(forKey: key.keyName) else { return nil }
        return coderService.decode(data: data)
    }

    /// Check whether a value is saved to the given key.
    /// - Parameters:
    ///   - key: the key.
    /// - Returns:
    ///     Whether a stored value is found for the given key.
    func has(key: Key) -> Bool {
        do {
            let result = try valet.containsObject(forKey: key.keyName)
            return result
        } catch {
            return false
        }
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    /// - Returns:
    ///     Whether the operation was successful.
    @discardableResult func delete<T>(forKey key: Key) -> T? where T: Codable {
        let result: T? = retrieve(forKey: key)
        try? valet.removeObject(forKey: key.keyName)
        return result
    }

    /// Delete the stored value from the device.
    /// - Parameters:
    ///   - forKey: the value that is associated with this key will be deleted.
    func delete(forKey key: Key) {
        try? valet.removeObject(forKey: key.keyName)
    }
}
