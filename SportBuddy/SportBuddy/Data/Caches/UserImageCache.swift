//
//  UserImageCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 10. 02..
//

import Foundation

final class UserImageCache: Cache<UserImageCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        var images: [UUID: String]
    }
}
