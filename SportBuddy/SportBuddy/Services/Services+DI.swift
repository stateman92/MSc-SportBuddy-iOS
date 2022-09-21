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

        register(service: AnimationServiceImpl(), implements: AnimationService.self)
        register(service: CameraServiceImpl(), implements: CameraService.self)
        register(service: CoderServiceImpl(), implements: CoderService.self)
        register(service: ConnectivityServiceImpl(), implements: ConnectivityService.self)
        register(service: CopyServiceImpl(), implements: CopyService.self)
        register(service: DateFormatterServiceImpl(), implements: DateFormatterService.self)
        register(service: ImageLoadingServiceImpl(), implements: ImageLoadingService.self)
        register(service: LoggingServiceImpl(), implements: LoggingService.self)
        register(service: MLServiceImpl(), implements: MLService.self)
        register(service: NavigatorServiceImpl(rootViewController: resolve() as OnboardingScreen),
                 implements: NavigatorService.self)
        register(service: SystemImageServiceImpl(), implements: SystemImageService.self)
        register(service: WebSocketServiceImpl(), implements: WebSocketService.self)
    }
}

extension DependencyInjector {
    private static func registerToast() {
        register(service: ToastServiceImpl(on: UIApplication.keyWindow), implements: ToastService.self)
    }

    private static func registerSettings() {
        register(service: DefaultSettingsServiceImpl(), implements: DefaultSettingsService.self)
        register(service: SecureSettingsServiceImpl(), implements: SecureSettingsService.self)
        register(service: SettingsServiceImpl(), implements: SettingsService.self)
    }

    private static func registerLoading() {
        register(service: LoadingOverlayServiceImpl(), implements: LoadingOverlayService.self)
        register(service: LoadingServiceImpl(), implements: LoadingService.self)
    }

    private static func register<T, S>(service: @autoclosure @escaping () -> T, implements implemented: S.Type) {
        resolver.register { service() }.implements(implemented).scope(.application)
    }
}
