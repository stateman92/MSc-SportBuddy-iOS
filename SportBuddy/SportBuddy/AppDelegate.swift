//
//  AppDelegate.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import UIKit

@main
final class AppDelegate: UIResponder {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppLoader.setup()
        return true
    }
}

// MARK: UISceneSession Lifecycle

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
