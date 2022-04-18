//
//  Mock+DI.swift
//  SportBuddyTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

@testable import SportBuddy

extension DependencyInjector {
    /// Register all the dependencies of the application for tests.
    static func registerDependenciesForTests() {
        registerServicesForTests()
    }
}

extension DependencyInjector {
    private static func registerServicesForTests() {
        resolver
            .register { AnimationServiceProtocolMock() }
            .implements(AnimationServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { ImageLoadingServiceProtocolMock() }
            .implements(ImageLoadingServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { LoadingOverlayServiceProtocolMock() }
            .implements(LoadingOverlayServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { LoadingServiceProtocolMock() }
            .implements(LoadingServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { MLServiceProtocolMock() }
            .implements(MLServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { NavigatorServiceProtocolMock(rootViewController: .init()) }
            .implements(NavigatorServiceProtocol.self)
            .scope(.unique)

        resolver
            .register { SystemImageService() }
            .implements(SystemImageServiceProtocol.self)
            .scope(.unique)
    }
}
