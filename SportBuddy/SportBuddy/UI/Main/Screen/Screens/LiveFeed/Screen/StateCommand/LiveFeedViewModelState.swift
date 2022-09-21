//
//  LiveFeedViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 12..
//

struct LiveFeedViewModelState {
    let liveFeed: [LiveFeedResponseDTO]
}

extension LiveFeedViewModelState: Initable {
    init() {
        self.init(liveFeed: .init())
    }
}

extension LiveFeedViewModelState: Equatable { }
