//
//  TokenCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 18..
//

import Foundation

final class TokenCache: PersistentCache<TokenCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let token: UUID
    }

    // MARK: Initialization

    init() {
        super.init(key: .token)
    }
}
