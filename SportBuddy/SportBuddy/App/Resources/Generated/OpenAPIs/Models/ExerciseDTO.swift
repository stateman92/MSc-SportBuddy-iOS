//
// ExerciseDTO.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ExerciseDTO: Codable, JSONEncodable, Hashable {

    public var primaryId: UUID
    public var exerciseType: ExerciseTypeDTO
    public var previewImage: String
    public var exerciseVideoUrl: String
    public var fractions: [ExerciseFractionDTO]

    public init(primaryId: UUID, exerciseType: ExerciseTypeDTO, previewImage: String, exerciseVideoUrl: String, fractions: [ExerciseFractionDTO]) {
        self.primaryId = primaryId
        self.exerciseType = exerciseType
        self.previewImage = previewImage
        self.exerciseVideoUrl = exerciseVideoUrl
        self.fractions = fractions
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case primaryId
        case exerciseType
        case previewImage
        case exerciseVideoUrl
        case fractions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(primaryId, forKey: .primaryId)
        try container.encode(exerciseType, forKey: .exerciseType)
        try container.encode(previewImage, forKey: .previewImage)
        try container.encode(exerciseVideoUrl, forKey: .exerciseVideoUrl)
        try container.encode(fractions, forKey: .fractions)
    }
}

