//
// UserDB.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct UserDB: Codable, JSONEncodable, Hashable {

    public var id: UUID?
    public var name: String
    public var email: String
    public var password: String
    public var profileImage: String
    public var token: String?
    public var chats: [UUID]

    public init(id: UUID? = nil, name: String, email: String, password: String, profileImage: String, token: String? = nil, chats: [UUID]) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.profileImage = profileImage
        self.token = token
        self.chats = chats
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case email
        case password
        case profileImage
        case token
        case chats
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(profileImage, forKey: .profileImage)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encode(chats, forKey: .chats)
    }
}

