//
//  Services+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

extension DependencyInjector {
    /// Register all the service-related dependencies of the application.
    static func registerServices() {
        resolver
            .register { AnimationService() }
            .implements(AnimationServiceProtocol.self)
            .scope(.application)

        resolver
            .register { CoderService() }
            .implements(CoderServiceProtocol.self)
            .scope(.application)

        resolver
            .register { ImageLoadingService() }
            .implements(ImageLoadingServiceProtocol.self)
            .scope(.application)

        resolver
            .register { LoadingOverlayService() }
            .implements(LoadingOverlayServiceProtocol.self)
            .scope(.application)

        resolver
            .register { LoadingService() }
            .implements(LoadingServiceProtocol.self)
            .scope(.application)

        resolver
            .register { LoggingService() }
            .implements(LoggingServiceProtocol.self)
            .scope(.application)

        resolver
            .register { MLService() }
            .implements(MLServiceProtocol.self)
            .scope(.application)

        resolver
            .register { NavigatorService(rootViewController: resolve() as OnboardingScreen) }
            .implements(NavigatorServiceProtocol.self)
            .scope(.application)

        resolver
            .register { NetworkService() }
            .implements(NetworkServiceProtocol.self)
            .scope(.application)

        resolver
            .register { SettingsService() }
            .implements(SettingsServiceProtocol.self)
            .scope(.application)

        resolver
            .register { SystemImageService() }
            .implements(SystemImageServiceProtocol.self)
            .scope(.application)

        resolver
            .register { WebSocketService() }
            .implements(WebSocketServiceProtocol.self)
            .scope(.application)
    }
}
