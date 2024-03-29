//
//  ChatsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsCache: Cache<ChatsCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let chats: [ChatDTO]
    }
}
