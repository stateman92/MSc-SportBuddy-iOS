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
//        resolver
//            .register { AnimationServiceMock() }
//            .implements(AnimationService.self)
//            .scope(.unique)
//
//        resolver
//            .register { LoadingOverlayServiceMock() }
//            .implements(LoadingOverlayService.self)
//            .scope(.unique)
//
//        resolver
//            .register { LoadingServiceMock() }
//            .implements(LoadingService.self)
//            .scope(.unique)
//
//        resolver
//            .register { MLServiceMock() }
//            .implements(MLService.self)
//            .scope(.unique)
//
//        resolver
//            .register { SystemImageServiceMock() }
//            .implements(SystemImageService.self)
//            .scope(.unique)
    }
}
