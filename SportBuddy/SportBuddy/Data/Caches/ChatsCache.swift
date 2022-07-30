//
//  ChatsCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 01..
//

final class ChatsCache: GeneralCache<[ChatDTO]> {
    // MARK: Initialization

    init() {
        super.init(cacheType: .default)
    }
}
