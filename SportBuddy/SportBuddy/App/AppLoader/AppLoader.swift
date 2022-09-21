//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import UIKit

enum AppLoader {
    // MARK: Properties

    @LazyInjected private static var loginDomain: LoginDomainImpl
    @LazyInjected private static var navigatorService: NavigatorService
    private static var window: UIWindow?
    private static var cancellables = Cancellables()
}

// MARK: - Public methods

extension AppLoader {
    static func setup(window: UIWindow?) {
        self.window = window
        setup()
        navigatorService.resetToDefault()
        setupWindow()
    }
}

// MARK: - Setups

extension AppLoader {
    private static func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        navigatorService.becameRoot(in: window)
        window.makeKeyAndVisible()
    }
}

// MARK: - Helpers

extension AppLoader {
    private static func setup() {
        DependencyInjector.registerDependencies()

        OpenAPIClientAPI.basePath = "http://127.0.0.1:8080"
        OpenAPIClientAPI.apiResponseQueue = .global(qos: .userInitiated)
        OpenAPIClientAPI.requestBuilderFactory = TokenizableRequestBuilderFactory()
        NotificationCenter.addObserver(forName: .name(UIApplication.willEnterForegroundNotification)) {
            loginDomain
                .action
                .refreshToken()
                .sink(receiveError: { _ in
                    navigatorService.resetToDefault()
                })
                .store(in: &cancellables)
        }
    }
}
