//
//  CoderServiceImpl.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import Foundation

/// A class for coding (encoding and decoding) objects.
final class CoderServiceImpl { }

// MARK: - CoderService

extension CoderServiceImpl: CoderService {
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
