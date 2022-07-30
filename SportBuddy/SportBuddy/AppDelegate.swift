//
//  AppDelegate.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppLoader.setup(window: window)
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        AppLoader.application(app, open: url, options: options)
    }
}
