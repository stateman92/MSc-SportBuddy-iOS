//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import GoogleSignIn

enum AppLoader {
    // MARK: Properties

    @LazyInjected private static var loginDomain: LoginDomain
    @LazyInjected private static var navigatorService: NavigatorServiceProtocol
    private static var cancellables = Cancellables()

    static var signInConfig: GIDConfiguration {
        let id = ""
        return GIDConfiguration(clientID: id)
    }
}

// MARK: - Public methods

extension AppLoader {
    static func setup() {
        DependencyInjector.registerDependencies()

        OpenAPIClientAPI.basePath = "http://127.0.0.1:8080"
        OpenAPIClientAPI.apiResponseQueue = .global(qos: .userInitiated)
        OpenAPIClientAPI.requestBuilderFactory = TokenizableRequestBuilderFactory()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
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

    static func setupUI(windowScene: UIWindowScene) -> UIWindow {
        navigatorService.resetToDefault()
        return UIWindow(windowScene: windowScene).then {
            navigatorService.becameRoot(in: $0)
            $0.makeKeyAndVisible()
        }
    }

    static func application(_ app: UIApplication,
                            open url: URL,
                            options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        return false
    }
}
