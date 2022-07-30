//
//  TokenCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 18..
//

import Foundation

final class TokenCache: GeneralCache<UUID> {
    // MARK: Initialization

    init() {
        super.init(cacheType: .persistent(key: .token))
    }
}
