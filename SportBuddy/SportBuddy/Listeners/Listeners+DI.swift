//
//  Listeners+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 18..
//

extension DependencyInjector {
    /// Register all the listeners-related dependencies of the application.
    static func registerListeners() {
        resolver.register { ConnectivityListenerImpl() }.implements(ConnectivityListener.self)
        resolver.register { WebSocketListenerImpl() }.implements(WebSocketListener.self)
    }
}
