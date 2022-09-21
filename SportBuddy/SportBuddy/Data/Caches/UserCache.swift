//
//  UserCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class UserCache: GeneralCache<UserCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let user: UserDTO
    }

    // MARK: Initialization

    init() {
        super.init(cacheType: .persistent(key: .user))
    }
}
