//
//  LiveFeed+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 12..
//

extension DependencyInjector {
    /// Register all the dependencies of the settings module.
    static func registerLiveFeedScreen() {
        resolver.register { LiveFeedScreen() }
        resolver.register { LiveFeedViewModel() }
    }
}
