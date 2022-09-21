//
//  LiveFeedCache.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 17..
//

final class LiveFeedCache: GeneralCache<LiveFeedCache.Object> {
    // MARK: Nested types

    struct Object: Codable {
        let liveFeeds: [LiveFeedResponseDTO]
    }
}
