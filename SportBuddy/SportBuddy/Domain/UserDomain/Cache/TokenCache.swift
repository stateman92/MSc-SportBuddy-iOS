//
//  TokenCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 18..
//

import Foundation

final class TokenCache: PersistentCache<UUID> {
    // MARK: Initialization

    init() {
        super.init(key: StringKey(keyName: "token"), secure: true)
    }

    override func save(item: UUID) {
        super.save(item: item)
        print("Token: \(item).")
    }
}
