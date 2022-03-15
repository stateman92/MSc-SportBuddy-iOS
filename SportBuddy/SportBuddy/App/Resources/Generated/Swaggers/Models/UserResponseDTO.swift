//
// UserResponseDTO.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct UserResponseDTO: Codable {

    public var token: UUID
    public var user: UserDTO

    public init(token: UUID, user: UserDTO) {
        self.token = token
        self.user = user
    }


}

