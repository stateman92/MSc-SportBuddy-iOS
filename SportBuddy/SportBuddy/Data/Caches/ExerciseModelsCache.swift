//
//  ExerciseModelsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 19..
//

import Foundation

final class ExerciseModelsCache: Cache<ExerciseModelsCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        var exericesModels: [ExerciseModel] = .init()
    }
}
