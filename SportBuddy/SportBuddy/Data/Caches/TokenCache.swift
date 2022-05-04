//
//  TokenCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 18..
//

import Foundation

final class TokenCache: PersistentCache<UUID> {
    // MARK: Initialization

    required init() {
        super.init(key: .token)
    }
}
