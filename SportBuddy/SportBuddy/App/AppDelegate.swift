//
//  AppDelegate.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import UIKit

@main
final class AppDelegate: UIResponder {
    // MARK: Properties

    var window: UIWindow?
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppLoader.setup(window: window)
        return true
    }
}
