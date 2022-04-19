//
//  TokenCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 18..
//

final class TokenCache: PersistentCache<String> {
    // MARK: Initialization

    init() {
        super.init(key: StringKey(keyName: "token"))
    }
}
