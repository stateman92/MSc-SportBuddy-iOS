//
//  UserCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class UserCache: GeneralCache<UserDTO> {
    // MARK: Initialization

    init() {
        super.init(cacheType: .persistent(key: .user))
    }
}
