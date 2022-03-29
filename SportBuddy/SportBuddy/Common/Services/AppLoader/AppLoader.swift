//
//  AppLoader.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 03. 29..
//

struct AppLoader {
    private init() { }
}

extension AppLoader {
    static func setup() {
        DependencyInjector.registerDependencies()
        SwaggerClientAPI.basePath = "https://sportbuddy-backend.herokuapp.com"
    }
}
