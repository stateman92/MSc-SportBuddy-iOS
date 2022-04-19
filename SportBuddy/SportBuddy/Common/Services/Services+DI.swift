//
//  Services+DI.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 04. 15..
//

import UIKit

extension DependencyInjector {
    /// Register all the service-related dependencies of the application.
    static func registerServices() {
        registerToast()
        registerSettings()
        registerLoading()

        register(service: AnimationService(), implements: AnimationServiceProtocol.self)
        register(service: CameraService(), implements: CameraServiceProtocol.self)
        register(service: CoderService(), implements: CoderServiceProtocol.self)
        register(service: ImageLoadingService(), implements: ImageLoadingServiceProtocol.self)
        register(service: LoggingService(), implements: LoggingServiceProtocol.self)
        register(service: MLService(), implements: MLServiceProtocol.self)
        register(service: NavigatorService(rootViewController: resolve() as OnboardingScreen),
                 implements: NavigatorServiceProtocol.self)
        register(service: SystemImageService(), implements: SystemImageServiceProtocol.self)
        register(service: WebSocketService(), implements: WebSocketServiceProtocol.self)
    }
}

extension DependencyInjector {
    private static func registerToast() {
        register(service: ToastService(on: UIApplication.keyWindow), implements: ToastServiceProtocol.self)
    }

    private static func registerSettings() {
        register(service: DefaultSettingsService(), implements: DefaultSettingsServiceProtocol.self)
        register(service: SecureSettingsService(), implements: SecureSettingsServiceProtocol.self)
        register(service: SettingsService(), implements: SettingsServiceProtocol.self)
    }

    private static func registerLoading() {
        register(service: LoadingOverlayService(), implements: LoadingOverlayServiceProtocol.self)
        register(service: LoadingService(), implements: LoadingServiceProtocol.self)
    }

    private static func register<T, S>(service: @autoclosure @escaping () -> T, implements implemented: S.Type) {
        resolver.register { service() }.implements(implemented).scope(.application)
    }
}
