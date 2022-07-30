//
//  CoderService.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation

/// A protocol for coding (encoding and decoding) objects.
protocol CoderService: Initable {
    /// Encode the given object.
    /// - Parameters:
    ///   - object: the object.
    /// - Note:
    /// This method gives a unified method to encode objects.
    /// - Returns:
    ///     The encoded `Data?`.
    func encode<T>(object: T?) -> Data? where T: Codable

    /// Decode the given data.
    /// - Parameters:
    ///   - data: the data.
    /// - Note:
    /// This method gives a unified method to decode objects.
    /// - Returns:
    ///     The decoded object.
    func decode<T>(data: Data?) -> T? where T: Codable
}

extension CoderService {
    /// Encode the given object.
    /// - Parameters:
    ///   - object: the object.
    /// - Note:
    /// This method gives a unified method to encode objects.
    /// - Returns:
    ///     The encoded `String?`.
    func encode<T>(object: T?) -> String? where T: Codable {
        guard let data = encode(object: object) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    /// Decode the given string.
    /// - Parameters:
    ///   - string: the string.
    /// - Note:
    /// This method gives a unified method to decode objects.
    /// - Returns:
    ///     The decoded object.
    func decode<T>(string: String?) -> T? where T: Codable {
        decode(data: string?.data(using: .utf8))
    }
}
