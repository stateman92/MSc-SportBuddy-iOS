//
//  UserCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class UserCache: PersistentCache<UserDTO> {
    // MARK: Initialization

    required init() {
        super.init(key: .user)
    }
}
