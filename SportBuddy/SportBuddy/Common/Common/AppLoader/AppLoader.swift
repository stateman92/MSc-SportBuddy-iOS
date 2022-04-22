//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import GoogleSignIn
import IQKeyboardManagerSwift

struct AppLoader {
    // MARK: Properties

    static var signInConfig: GIDConfiguration {
        let id = ""
        return GIDConfiguration(clientID: id)
    }

    private init() { }
}

// MARK: - Public methods

extension AppLoader {
    static func setup() {
        DependencyInjector.registerDependencies()
        OpenAPIClientAPI.basePath = "https://sportbuddy-backend.herokuapp.com"
        OpenAPIClientAPI.apiResponseQueue = .global(qos: .userInitiated)
        OpenAPIClientAPI.requestBuilderFactory = TokenizableRequestBuilderFactory()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        _ = AnimatedKeyboardObserver.shared
        IQKeyboardManager.shared.enable = true
    }

    static func setupUI(windowScene: UIWindowScene) -> UIWindow {
        let navigatorService: NavigatorServiceProtocol = DependencyInjector.resolve()
        navigatorService.isNavigationBarHidden = true
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
