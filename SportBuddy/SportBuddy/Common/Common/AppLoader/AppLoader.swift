//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

import GoogleSignIn
import IQKeyboardManagerSwift

struct AppLoader {
    static var signInConfig: GIDConfiguration {
        let id = "748558315095-al2qh257aee11chn5anbf73qqve43ah4.apps.googleusercontent.com"
        return GIDConfiguration(clientID: id)
    }

    private init() { }
}

extension AppLoader {
    static func setup() {
        DependencyInjector.registerDependencies()
        SwaggerClientAPI.basePath = "https://sportbuddy-backend.herokuapp.com"
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
        let navigationController: UINavigationController = DependencyInjector.resolve()
        navigationController.then {
            $0.isNavigationBarHidden = true
        }
        return UIWindow(windowScene: windowScene).then {
            $0.rootViewController = navigationController
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
