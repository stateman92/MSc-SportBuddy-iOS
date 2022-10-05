//
//  LiveFeedViewModelState.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 12..
//

import UIKit

struct LiveFeedViewModelState {
    let liveFeed: [LiveFeedResponseDTO]
    var lastIndexPath: IndexPath {
        .init(row: liveFeed.count - 1, section: .zero)
    }
}

extension LiveFeedViewModelState: Initable {
    init() {
        self.init(liveFeed: .init())
    }
}

extension LiveFeedViewModelState: Equatable { }
