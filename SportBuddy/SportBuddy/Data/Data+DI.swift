//
//  Data+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 05. 02..
//

extension DependencyInjector {
    /// Register all the data-related dependencies of the application.
    static func registerData() {
        registerCaches()
    }
}

extension DependencyInjector {
    private static func registerCaches() {
        register(cache: SearchedUsersCache())
        register(cache: ChatsCache())
        register(cache: UserCache())
        register(cache: TokenCache())
    }

    private static func register<T, S>(cache: T) where T: Cache<S> {
        resolver.register { cache }.scope(.application)
    }
}
