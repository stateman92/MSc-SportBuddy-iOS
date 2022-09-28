//
//  SearchedUsersCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class SearchedUsersCache: Cache<SearchedUsersCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let users: [UserDTO]
    }
}
